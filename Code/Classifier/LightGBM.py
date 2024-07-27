from sklearn.model_selection import StratifiedKFold
from sklearn.metrics import roc_curve, auc
import math
import time
import os
import pandas as pd
import numpy as np
import scipy.io

#os.chdir('C:\\Users\\Personal\\Desktop\\daima\\Results_files\\H.pylori')  # 修改当前工作目录路径
#index = pd.read_csv('H_index.csv', header=None)
#index = np.array(list(index.iloc[:, 0]))

os.chdir('C:\\Users\\Personal\\Desktop\\daima\\Results_files\\S.cerevisiae')  # 修改当前工作目录路径
index = pd.read_csv('S_index.csv', header=None)
index = np.array(list(index.iloc[:, 0]))

H_PseAAC = scipy.io.loadmat('T_S_PseAAC_8.mat')
H_PseAAC = H_PseAAC.get('S_PseAAC')
H_PseAAC = H_PseAAC[index, :]
H_PseAAC = pd.DataFrame(H_PseAAC)

def to_categorical(y, nb_classes=None):
    y = np.array(y, dtype='int')
    if not nb_classes:
        nb_classes = np.max(y) + 1
    Y = np.zeros((len(y), nb_classes))
    for i in range(len(y)):
        Y[i, y[i]] = 1.
    return Y

def categorical_probas_to_classes(p):
    return np.argmax(p, axis=1)


def calculate_performace(test_num, pred_y, labels):
    tp = 0
    fp = 0
    tn = 0
    fn = 0
    for index in range(test_num):
        if labels[index] == 1:
            if labels[index] == pred_y[index]:
                tp = tp + 1
            else:
                fn = fn + 1
        else:
            if labels[index] == pred_y[index]:
                tn = tn + 1
            else:
                fp = fp + 1

    acc = float(tp + tn) / test_num
    precision = float(tp) / (tp + fp + 1e-06)
    npv = float(tn) / (tn + fn + 1e-06)
    sensitivity = float(tp) / (tp + fn + 1e-06)
    specificity = float(tn) / (tn + fp + 1e-06)
    mcc = float(tp * tn - fp * fn) / (math.sqrt((tp + fp) * (tp + fn) * (tn + fp) * (tn + fn)) + 1e-06)
    f1 = float(tp * 2) / (tp * 2 + fp + fn + 1e-06)
    return acc, precision, npv, sensitivity, specificity, mcc, f1

rnn_output1 = pd.read_csv('rnn_output.csv', header=None)
rnn_output1 = np.array(rnn_output1)

X = rnn_output1
y = np.array(H_PseAAC.iloc[:, 0])

time0 = time.time()
import lightgbm as lgb
cv_clf = lgb.LGBMClassifier(random_state=1)
sepscores = []
skf= StratifiedKFold(n_splits=5)
ytest=np.ones((1,2))*0.5
yscore=np.ones((1,2))*0.5

for train, test in skf.split(X,y):
    X_train_enc=cv_clf.fit(X[train], y[train])
    y_score=cv_clf.predict_proba(X[test])
    yscore=np.vstack((yscore,y_score))
    y_test=to_categorical(y[test])
    ytest=np.vstack((ytest,y_test))
    fpr, tpr, _ = roc_curve(y_test[:,0], y_score[:,0])
    roc_auc = auc(fpr, tpr)
    y_class= categorical_probas_to_classes(y_score)
    y_test_tmp=y[test]
    acc, precision,npv, sensitivity, specificity, mcc,f1 = calculate_performace(len(y_class), y_class, y_test_tmp)
    sepscores.append([acc, precision,npv, sensitivity, specificity, mcc,f1,roc_auc])
    print('LGBM:acc=%f,precision=%f,npv=%f,sensitivity=%f,specificity=%f,mcc=%f,f1=%f,roc_auc=%f'
          % (acc, precision,npv, sensitivity, specificity, mcc,f1, roc_auc))
scores=np.array(sepscores)
print("acc=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[0]*100,np.std(scores, axis=0)[0]*100))
print("precision=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[1]*100,np.std(scores, axis=0)[1]*100))
print("npv=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[2]*100,np.std(scores, axis=0)[2]*100))
print("sensitivity=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[3]*100,np.std(scores, axis=0)[3]*100))
print("specificity=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[4]*100,np.std(scores, axis=0)[4]*100))
print("mcc=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[5]*100,np.std(scores, axis=0)[5]*100))
print("f1=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[6]*100,np.std(scores, axis=0)[6]*100))
print("roc_auc=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[7]*100,np.std(scores, axis=0)[7]*100))
result=np.mean(scores,axis=0)
HS=result.tolist()#数据类型转换为列表
sepscores.append(HS)
data_csv = pd.DataFrame(data=sepscores)
data_csv.to_csv('LGBM.csv')

row=yscore.shape[0]
yscore=yscore[np.array(range(1,row)),:]
yscore = pd.DataFrame(data=yscore)
yscore.to_csv('yscore_LGBM.csv')
ytest=ytest[np.array(range(1,row)),:]
ytest = pd.DataFrame(data=ytest)
ytest.to_csv('ytest_LGBM.csv')
print('训练时长：', (time.time()-time0))
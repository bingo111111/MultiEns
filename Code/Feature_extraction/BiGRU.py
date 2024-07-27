import os
import numpy as np
import pandas as pd
import scipy.io
from tensorflow.keras.layers import Input
from tensorflow.keras import layers
from tensorflow.keras.models import Model
from tensorflow.keras.optimizers import Adam

#os.chdir('C:\\Users\\Personal\\Desktop\\daima\\Results_files\\H.pylori')  # 修改当前工作目录路径
os.chdir('C:\\Users\\Personal\\Desktop\\daima\\Results_files\\S.cerevisiae')  # 修改当前工作目录路径

#row=2916
row=11188
index = [i for i in range(row)]
np.random.shuffle(index)
index=np.array(index)

index_=pd.DataFrame(index)
index_.to_csv('S_index.csv',header=False,index=False)

index=pd.read_csv('S_index.csv',header=None)
index=np.array(list(index.iloc[:,0]))

H_PseAAC = scipy.io.loadmat('T_S_PseAAC_8.mat')
H_PseAAC = H_PseAAC.get('S_PseAAC')
H_PseAAC = H_PseAAC[index, :]
H_PseAAC = pd.DataFrame(H_PseAAC)

H_AD = scipy.io.loadmat('T_S_AD_7.mat')
H_AD = H_AD.get('S_AD')
H_AD = H_AD[index, :]
H_AD = pd.DataFrame(H_AD)

H_AC = scipy.io.loadmat('T_S_AC_9.mat')
H_AC = H_AC.get('S_AC')
H_AC = H_AC[index, :]
H_AC = pd.DataFrame(H_AC)

H_CT = scipy.io.loadmat('T_S_CT.mat')
H_CT = H_CT.get('T_S_CT')
H_CT = H_CT[index, :]
H_CT = pd.DataFrame(H_CT)

H_LD = scipy.io.loadmat('T_S_LD.mat')
H_LD = H_LD.get('S_LD')
H_LD = H_LD[index, :]
H_LD = pd.DataFrame(H_LD)

H_MMI = scipy.io.loadmat('T_S_MMI.mat')
H_MMI = H_MMI.get('S_MMI')
H_MMI = H_MMI[index, :]
H_MMI = pd.DataFrame(H_MMI)

def rnn_model1(x, y):
    x_input = Input(shape=(56, 1))  # 输入样本的shape

    rnn = layers.Bidirectional(layers.GRU(4))(x_input)  # rnn操作

    model = Model([x_input], outputs=[rnn])  # 定义模型的输入输出

    model.compile(optimizer=Adam(learning_rate=0.001, clipvalue=1.0), loss='binary_crossentropy')

    model.fit(x, y, epochs=5, batch_size=16, validation_split=0.1)  # 模型训练
    rnn_output = model.predict(x)
    return rnn_output

output1 = rnn_model1(H_PseAAC.iloc[:, 1:], H_PseAAC.iloc[:, 0])

def rnn_model2(x, y):
    x_input = Input(shape=(546, 1))  # 输入样本的shape

    rnn = layers.Bidirectional(layers.GRU(64))(x_input)  # rnn操作

    model = Model([x_input], outputs=[rnn])  # 定义模型的输入输出

    model.compile(optimizer=Adam(learning_rate=0.001, clipvalue=1.0), loss='binary_crossentropy')

    model.fit(x, y, epochs=5, batch_size=16, validation_split=0.1)  # 模型训练
    rnn_output = model.predict(x)
    return rnn_output

output2 = rnn_model2(H_AD.iloc[:, 1:], H_AD.iloc[:, 0])

def rnn_model3(x, y):
    x_input = Input(shape=(234, 1))  # 输入样本的shape

    rnn = layers.Bidirectional(layers.GRU(16))(x_input)  # rnn操作

    model = Model([x_input], outputs=[rnn])  # 定义模型的输入输出

    model.compile(optimizer=Adam(learning_rate=0.001, clipvalue=1.0), loss='binary_crossentropy')

    model.fit(x, y, epochs=5, batch_size=16, validation_split=0.1)  # 模型训练
    rnn_output = model.predict(x)
    return rnn_output

output3 = rnn_model3(H_AC.iloc[:, 1:], H_AC.iloc[:, 0])

def rnn_model4(x, y):
    x_input = Input(shape=(686, 1))  # 输入样本的shape

    rnn = layers.Bidirectional(layers.GRU(64))(x_input)  # rnn操作

    model = Model([x_input], outputs=[rnn])  # 定义模型的输入输出

    model.compile(optimizer=Adam(learning_rate=0.001, clipvalue=1.0), loss='binary_crossentropy')

    model.fit(x, y, epochs=5, batch_size=16, validation_split=0.1)  # 模型训练
    rnn_output = model.predict(x)
    return rnn_output

output4 = rnn_model4(H_CT.iloc[:, 1:], H_CT.iloc[:, 0])

def rnn_model5(x, y):
    x_input = Input(shape=(1260, 1))  # 输入样本的shape

    rnn = layers.Bidirectional(layers.GRU(128))(x_input)  # rnn操作

    model = Model([x_input], outputs=[rnn])  # 定义模型的输入输出

    model.compile(optimizer=Adam(learning_rate=0.001, clipvalue=1.0), loss='binary_crossentropy')

    model.fit(x, y, epochs=5, batch_size=16, validation_split=0.1)  # 模型训练
    rnn_output = model.predict(x)
    return rnn_output

output5 = rnn_model5(H_LD.iloc[:, 1:], H_LD.iloc[:, 0])

def rnn_model6(x, y):
    x_input = Input(shape=(238, 1))  # 输入样本的shape

    rnn = layers.Bidirectional(layers.GRU(16))(x_input)  # rnn操作

    model = Model([x_input], outputs=[rnn])  # 定义模型的输入输出

    model.compile(optimizer=Adam(learning_rate=0.001, clipvalue=1.0), loss='binary_crossentropy')

    model.fit(x, y, epochs=5, batch_size=16, validation_split=0.1)  # 模型训练
    rnn_output = model.predict(x)
    return rnn_output

output6 = rnn_model6(H_MMI.iloc[:, 1:], H_MMI.iloc[:, 0])

rnn_output = np.concatenate((output1, output2, output3, output4, output5, output6), axis=1)

rnn_output_ = pd.DataFrame(rnn_output)
rnn_output_.to_csv('rnn_output.csv', header=False, index=False)
import re
#import readFasta
import numpy as np
import scipy.io as sio
import os

os.chdir('C:\\Users\\Personal\\Desktop\\multistack\\dataset\\S.cerevisiae')#修改当前工作目录路径

def CalculateKSCTriad(sequence, gap, features, AADict):
	res = []
	for g in range(gap+1):
		myDict = {}
		for f in features:
			myDict[f] = 0

		for i in range(len(sequence)):
			if i+gap+1 < len(sequence) and i+2*gap+2<len(sequence):
				fea = AADict[sequence[i]] + '.' + AADict[sequence[i+gap+1]]+'.'+AADict[sequence[i+2*gap+2]]
				myDict[fea] = myDict[fea] + 1

		maxValue, minValue = max(myDict.values()), min(myDict.values())
		for f in features:
			res.append((myDict[f] - minValue) / maxValue)

	return res


def CTriad(fastas, gap = 0):#它还接受任何附加的关键字参数(**kw)，尽管它们不在函数中使用。
	AAGroup = {
		'g1': 'AGV',
		'g2': 'ILFP',
		'g3': 'YMTS',
		'g4': 'HNQW',
		'g5': 'RK',
		'g6': 'DE',
		'g7': 'C'
	}

	myGroups = sorted(AAGroup.keys())#list = sorted(iterable, key=None, reverse=False)
	# 其中，iterable 表示指定的序列，key 参数可以自定义排序规则；
	# reverse 参数指定以升序（False，默认）还是降序（True）进行排序。sorted() 函数会返回一个排好序的列表。

	AADict = {}
	for g in myGroups:
		for aa in AAGroup[g]:
			AADict[aa] = g

	features = [f1 + '.'+ f2 + '.' + f3 for f1 in myGroups for f2 in myGroups for f3 in myGroups]
	#推导式的结果是将三个循环变量连接起来，并用点号.分隔它们，最终形成一个字符串。这个字符串被添加到最外层的方括号内，作为一个新元素加入到了 features 列表中。
	encodings = []
	header = ['#']
	for f in features:
		header.append(f)
	encodings.append(header)

	for i in fastas:
		sequence=re.sub('X', '', i)
		#code = [name]
		if len(sequence) < 3:
			print('Error: for "CTriad" encoding, the input fasta sequences should be greater than 3. \n\n')
			return 0
		code=CalculateKSCTriad(sequence, 0, features, AADict)
		encodings.append(code)

	return encodings

#fastas = readFasta.readFasta("featutre_extrction\\PPI_txt\\yeast_NB.txt")
#kw=  {'path': "E:\\examples\\",'train':"train-protein.txt",'label':"label.txt"}

data_=sio.loadmat(r'P_proteinB.mat')
data=data_.get('P_proteinB')
fastas=[]
for i in range(len(data)):
	fastas.append(data[i][0][0])

#fastas[j]=fastas[j][:-1].split(',')

data_CTriad=CTriad(fastas, gap = 0)
CTtriad1=np.array(data_CTriad)
CTtriad2=CTtriad1[1:]

#for i in range(len(CTtriad2)):
#	CTtriad2[i]=np.array(CTtriad2[i])
#CTtriad2=CTtriad2.T
CTtriad3=np.empty((len(CTtriad2),len(CTtriad2[0])))

for i in range(len(CTtriad2)):
	for j in range(len(CTtriad2[0])):
		CTtriad3[i][j]=CTtriad2[i][j]

#print(CTtriad3.ndim)
#print(CTtriad3.shape)

#print(CTtriad2)
#print(CTtriad2[0][0])
#CTtriad3=CTtriad3.astype(np.float)

#print(CTtriad3)
sio.savemat('S_CT_Pb.mat',{'S_CT_Pb':CTtriad3})


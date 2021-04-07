input = open('Derevo.ged', encoding='utf-8')
output = open('output.pl', 'w', encoding='utf-8')
s = input.read()
s = list(s.split())
A = s.count("NAME")
B = []
for i in range(A):
    B.append([0] * 4)
j = -1
k = 0
p = 0
M=[]
for i in range(len(s)):
    if s[i] == "NAME":
        k = 0
        if s[i+2]=="//":
            M = s[i+1]
        else:
            s[i+2] = s[i+2].replace("/", "")
            M = s[i+1] + "_" + s[i+2]
    if s[i] == "SEX" and s[i+1] == "M":
        p=1
        j=j+1
        B[j][0] = M
        print("sex(",B[j][0],", m).",sep='',file=output)
    if s[i] == "FAMS" and k == 0 and p==1:
        B[j][1] = s[i+1]
        k = k + 1
    elif s[i] == "FAMS" and p==1:
        B[j][2] = s[i+1]
    if s[i] == "FAMC" and p==1:
        B[j][3] = s[i+1]
    if s[i] == "INDI":
        p=0
p = 0
for i in range(len(s)):
    if s[i] == "NAME":
        k = 0
        if s[i+2]=="//":
            M = s[i+1]
        else:
            s[i+2] = s[i+2].replace("/", "")
            M = s[i+1] + "_" + s[i+2]
    if s[i] == "SEX" and s[i+1] == "F":
        p=1
        j=j+1
        B[j][0] = M
        print("sex(",B[j][0],", f).",sep='',file=output)
    if s[i] == "FAMS" and k == 0 and p==1:
        B[j][1] = s[i+1]
        k = k + 1
    elif s[i] == "FAMS" and p==1:
        B[j][2] = s[i+1]
    if s[i] == "FAMC" and p==1:
        B[j][3] = s[i+1]
    if s[i] == "INDI":
        p=0
B.pop(len(B)-1)
print(file = output)
for i in range(len(B)):
    print("parents(", end='', file = output)
    print(B[i][0], end='', file = output)
    for j in range(len(B)):
        if (B[i][3] == B[j][1] and B[j][1]!=0):
            print(",",B[j][0],end = '', file = output)
        if (B[i][3] == B[j][2] and B[j][2]!=0):
            print(",",B[j][0],end = '', file = output)
    if B[i][3] == 0:
        print(", father_NAN,", "mother_NAN", end = '', file = output)
    print(").", file = output)
print()
input.close()
output.close()

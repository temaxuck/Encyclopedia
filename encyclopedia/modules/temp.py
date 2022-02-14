import os

for filename in os.listdir(os.getcwd()+'\\URLPYR'):
    with open(os.path.join(os.getcwd()+'\\URLPYR', filename), 'r') as f:
        data = f.read()
    # print(data)
    data = data.replace('<a href="pyramid', '<a href="pyramid?q=')
    # data = data.replace('</p>', '')
    # data = data.replace('<p>', '')
    # data = data.replace('Symmetry', '<span>Symmetric</span>')

    with open(os.path.join(os.getcwd()+'\\URLPYR', filename), 'w') as f:
        f.write(data)
    
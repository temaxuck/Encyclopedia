import time
import random

v = ['Камень', 'Ножницы', 'Бумага']

print(f'{v[0]}...')
time.sleep(1)
print(f'{v[1]}...')
time.sleep(1)
print(f'{v[2]}...')
time.sleep(1)

print(f'Выпало :{v[random.randrange(0, len(v))]}')

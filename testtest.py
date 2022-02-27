# import hashlib

# a = -427732
# b = 32893892.2

# s = f'{a}_{b}'
# s2 = f'{a}_{b}'
# hashed_s = hashlib.sha256(s.encode())
# hashed_s2 = hashlib.sha256(s2.encode())
# print(hashed_s.hexdigest() == hashed_s2.hexdigest())
# print(hashed_s2.hexdigest())

def wrapper(func, args):
    func(*args)

def ffff(*args):
    print(args)

a = [30] * 3
wrapper(ffff, a)
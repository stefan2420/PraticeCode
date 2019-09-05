import os 

os.system('clear')

baseF = 220.00

cycles = int((16000000-2) / (baseF * 4))


def sleep(r16, r17, r18):

    output = 0
    output += 4             # CALL sleep
    output += 1             # ldi
    output += 1 * r16       # inc 
    output += 1 * r16       # ldi 
    output += 1 * r16 * r17 # inc 
    output += 1 * r16 * r17 # nop 
    output += 1 * r16 * r17 # cp 
    output += 4 * r16 * r17 # branch
    output -= 3 * r16       # ajust branch
    output += 1 * r16       # cp 
    output += 4 * r16       # branch
    output -= 3             # ajust branch

    output += 1             # ldi
    output += 1 * r18       # ldi
    output += 1 * r18       # cp 
    output += 4 * r18       # branch
    output -= 3             # ajust 

    output += 4             # RET             

    return output

for r16 in range(0,256):
    for r17 in range(0,256):
        for r18 in range(0,256):

            out = sleep(r16, r17, r18)
            diff = cycles - out
            if (diff < 5) and (diff >= 0):
                print('r16:',r16)
                print('r17:',r17)
                print('r18:',r18)
                print('diff:', diff)
                print('----------------------------')

                if diff == 0:
                    exit()


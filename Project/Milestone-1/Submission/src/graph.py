import sys
f2 = open(sys.argv[2],'w')
f2.write('tree\n')
f = open(sys.argv[1])
text = f.read().split('$#$#')
indent = 0
for ent in text:
    if ent == '[':
        indent += 1
    elif ent == ']':
        indent -= 1
    else:
        for _ in range(indent):
            f2.write('\t')
        f2.write(ent+'\n')
        
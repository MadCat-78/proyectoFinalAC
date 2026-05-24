import re

REG = {

    "$zero":0,

    "$t0":8,
    "$t1":9,
    "$t2":10,
    "$t3":11,
    "$t4":12,
    "$t5":13,
    "$t6":14,
    "$t7":15,
    "$t8":24,
    "$t9":25,

    "$s0":16,
    "$s1":17,
    "$s2":18,
    "$s3":19,
    "$s4":20,
    "$s5":21,
    "$s6":22,
    "$s7":23
}

R_TYPE = {
    "add":"100000",
    "sub":"100010",
    "and":"100100",
    "or":"100101",
    "slt":"101010"
}

I_TYPE = {
    "addi":"001000",
    "andi":"001100",
    "ori":"001101",
    "slti":"001010",
    "lw":"100011",
    "sw":"101011",
    "beq":"000100"
}

J_TYPE = {
    "j":"000010"
}

def tobin(x,bits):

    if x < 0:
        x = (1 << bits) + x

    return format(x,f'0{bits}b')

with open("program.asm") as f:
    lines = f.readlines()

clean = []

for line in lines:

    line = line.split("#")[0].strip()

    if line:
        clean.append(line)

labels = {}

pc = 0

for line in clean:

    if ":" in line:

        label = line.replace(":","").strip()

        labels[label] = pc

    else:
        pc += 4

machine = []

pc = 0

for line in clean:

    if ":" in line:
        continue

    tokens = re.split(r'[,\s()]+',line)

    tokens = [t for t in tokens if t]

    op = tokens[0]


    if op == "nop":

        machine.append("0"*32)


    elif op in R_TYPE:

        rd = REG[tokens[1]]
        rs = REG[tokens[2]]
        rt = REG[tokens[3]]

        instr = (
            "000000" +
            tobin(rs,5) +
            tobin(rt,5) +
            tobin(rd,5) +
            "00000" +
            R_TYPE[op]
        )

        machine.append(instr)


    elif op in ["addi","andi","ori","slti"]:

        rt = REG[tokens[1]]
        rs = REG[tokens[2]]
        imm = int(tokens[3])

        instr = (
            I_TYPE[op] +
            tobin(rs,5) +
            tobin(rt,5) +
            tobin(imm,16)
        )

        machine.append(instr)


    elif op in ["lw","sw"]:

        rt = REG[tokens[1]]
        imm = int(tokens[2])
        rs = REG[tokens[3]]

        instr = (
            I_TYPE[op] +
            tobin(rs,5) +
            tobin(rt,5) +
            tobin(imm,16)
        )

        machine.append(instr)


    elif op == "beq":

        rs = REG[tokens[1]]
        rt = REG[tokens[2]]

        label = tokens[3]

        target = labels[label]

        offset = (target - (pc + 4)) // 4

        instr = (
            I_TYPE[op] +
            tobin(rs,5) +
            tobin(rt,5) +
            tobin(offset,16)
        )

        machine.append(instr)


    elif op == "j":

        label = tokens[1]

        addr = labels[label] // 4

        instr = (
            J_TYPE[op] +
            tobin(addr,26)
        )

        machine.append(instr)

    pc += 4

with open("instrucciones.txt","w") as f:

    for m in machine:
        f.write(m+"\n")

print("Archivo instrucciones.txt generado")

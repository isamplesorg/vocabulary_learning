f = open("exa.txt", "r")
a = f.readlines()

pre = str()
rec = str()

# collection data
for i in range(0, len(a), 3):
    pre += a[i+1][11:]
    rec += a[i+2][8:]

pre = pre.replace("\n", ",")

pre = ("c(") + pre.strip(",") + (")")

rec = rec.replace("\n", ",")

rec = ("c(") + rec.strip(",") + (")")


print(pre)
print(rec)

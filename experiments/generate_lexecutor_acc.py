import matplotlib.pyplot as plt

# train_sizes = [
#     56396,
#     112792,
#     169188,
#     225584,
#     281980,
#     338376,
#     394772,
#     451168,
#     507564,
#     563960
# ]
    
# accuracies = [
#   0.824,
#   0.8497,
#   0.8571,
#   0.8697,
#   0.8701,
#   0.8739,
#   0.878,
#   0.8787,
#   0.8807,
#   0.8836
# ]

train_sizes = [41453, 82906, 124359, 165812, 207265, 248718, 331624, 414530]
accuracies = [0.8224, 0.8669, 0.886, 0.8921, 0.9006, 0.9016, 0.9105, 0.9144]

assert len(train_sizes) == len(accuracies)

plt.rcParams.update({'font.size': 14, 'font.family': 'Arial'})

# vertical line at size of original LExecutor training set
# plt.axvline(x=214365, color='r', linestyle='--')

plt.plot(train_sizes, accuracies, 'o-')
plt.xlabel('Training set size')
plt.ylabel('Accuracy')
plt.xlim(0, 500000)
plt.ylim(0.8, 0.93)
plt.savefig('lexecutor_acc.png')

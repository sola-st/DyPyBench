import re
import argparse

parser = argparse.ArgumentParser()
parser.add_argument(
    "--filename", "-f", type=str, help="Specify source file")
parser.add_argument(
    "--output", "-o", type=str, help="Specify destination file")


if __name__ == '__main__':
    args = parser.parse_args()
    
    with open(args.filename, 'r') as f:
        epoch = 0
        with open(args.output, 'a+') as output:
            output.write("Epoch,Top1,Top2,Top3,Top4,Top5")
            output.write('\n')
            for line in f:
                match = re.search(r".* validation accuracy: .*", line)
                
                if match:
                    accuracies = line.split('{')[1].split('}')[0].split(',')
                    output.write(str(epoch))
                    output.write(',')                    
                    for index, element in enumerate(accuracies):
                        acc = element.split(':')[1][1:]
                        output.write(acc)
                        if index == 4:
                            output.write('\n')
                        else:
                            output.write(',')
                    epoch += 1

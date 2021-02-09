import matplotlib.pyplot as plt
import numpy

DIM = 2
N = 2000
num_cluster = 10
condition = 10

x = numpy.random.rand(N, DIM)
y = numpy.zeros(N)

for t in range(condition):
    input()
    for k in range(num_cluster):
        fig = plt.scatter(x[y == k, 0], x[y == k, 1], marker='o')

    plt.show()

    if t == 0:
        index_ = numpy.random.choice(range(N), num_cluster, replace=False)
        mean = x[index_]
    else:
        for k in range(num_cluster):
            mean[k] = numpy.mean(x[y == k], axis=0)
    
    for i in range(N):
        dist = numpy.sum((mean - x[i])**2, axis=1)
        pred = numpy.argmin(dist)
        y[i] = pred

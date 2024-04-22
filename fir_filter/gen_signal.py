from numpy import cos, sin, pi, absolute, arange, round, random, savetxt


def gen_in_range(nsamples, t):
    x = cos(2*pi*0.5*t) + 0.2*sin(2*pi*2.5*t+0.1) + \
            0.2*sin(2*pi*15.3*t) + 0.1*sin(2*pi*16.7*t + 0.1) + \
                0.1*sin(2*pi*23.45*t+.8)
    rand = random.randn(nsamples)
    x = x + (rand/max(abs(rand))) / 3
    x = round( ((x/max(abs(x))) * (2**18-1)) )
    return x


def gen_noise(nsamples):
    x = random.randn(nsamples)
    x = x/max(abs(x)) * (2**18-1)
    return x


def gen_out_range(nsamples, t):
    x = cos(2*pi*15.5*t) + 0.2*sin(2*pi*30.5*t+0.1) + \
            0.2*sin(2*pi*15.3*t) + 0.1*sin(2*pi*16.7*t + 0.1) + \
                0.1*sin(2*pi*23.45*t+.8)
    rand = random.randn(nsamples)
    x = x + (rand/max(abs(rand))) / 3
    x = round( ((x/max(abs(x))) * (2**18-1)) )
    return x


sample_rate = 100.0
nsamples = 800
t = arange(nsamples) / sample_rate

signal_type = input("Type signal type inr - in range, outr - out range, noise - noise\n")

if signal_type == "inr":
    x = gen_in_range(nsamples, t)
elif signal_type == "outr":
    x = gen_out_range(nsamples, t)
elif signal_type == "noise":
    x = gen_noise(nsamples)
else:
    print("Unexpexted input")
    exit()

savetxt('input.txt',x,'%d')


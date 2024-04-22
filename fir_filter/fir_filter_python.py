from numpy import cos, sin, pi, absolute, arange, round
from scipy.signal import kaiserord, lfilter, firwin, freqz
from pylab import figure, clf, plot, xlabel, ylabel, xlim, ylim, title, grid, axes, show
import numpy

#------------------------------------------------
# Create a signal for demonstration.
#------------------------------------------------

sample_rate = 100.0
nsamples = 800
t = arange(nsamples) / sample_rate
with open("input.txt", "r") as f:
    x = [int(num) if num.strip().isdigit() or '-' in num else 0 for num in f.readlines() ]

#------------------------------------------------
# Create a FIR filter and apply it to x.
#------------------------------------------------

# The Nyquist rate of the signal.
nyq_rate = sample_rate / 2.0

# The desired width of the transition from pass to stop,
# relative to the Nyquist rate.  We'll design the filter
# with a 5 Hz transition width.
width = 3.0/nyq_rate

# The desired attenuation in the stop band, in dB.
ripple_db = 70.0

# Compute the order and Kaiser parameter for the FIR filter.
N, beta = kaiserord(ripple_db, width)
# after func N = 146
N = 128
# The cutoff frequency of the filter.
cutoff_hz = 10.0

# Use firwin with a Kaiser window to create a lowpass FIR filter.
taps = firwin(N, cutoff_hz/nyq_rate, window=('kaiser', beta))

taps = round((taps/max(abs(taps)) * (2**16-1)))

# Use lfilter to filter x with the FIR filter.
filtered_x = round(lfilter(taps, 1.0, x) / (2**16-1))

#------------------------------------------------
# Plot the original and filtered signals.
#------------------------------------------------

# The phase delay of the filtered signal.
delay = 0.5 * (N-1) / sample_rate

with open("output_verilog", "r") as f:
    number = [int(x) if x.strip().isdigit() or '-' in x else 0 for x in f.readlines() ]

figure(1)
# Plot the original signal.
plot(t, x)
# Plot the filtered signal, shifted to compensate for the phase delay.
plot(t-delay, number, 'r-')
# Plot just the "good" part of the filtered signal.  The first N-1
# samples are "corrupted" by the initial conditions.
plot(t-delay, filtered_x, 'g')

xlabel('t')
grid(True)

show()


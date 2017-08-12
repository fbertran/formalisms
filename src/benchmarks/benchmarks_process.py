import sys
import pandas as ps
import numpy as np

df = ps.read_csv(sys.argv[1], dtype={"t2": np.float32})

seconds = np.array(df["t2"])

m = np.mean(seconds)

if m > 60:
  minutes = m / 60
  print("{} seconds mean ({} minutes)".format(m, minutes))
else:
  print("{} seconds mean".format(m))

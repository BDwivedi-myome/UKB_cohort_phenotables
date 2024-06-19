import pandas as pd
pd.to_datetime("11/23/2010 6:00 PM", format="%m/%d/%Y %I:%M %p")
import locale
locale.setlocale(locale.LC_TIME, ('en_US', 'UTF-8'))

def read_pkl_file(file, date_cols):
  pkl_data = pd.read_pickle(file)
  try:
    if date_cols is None:
       return pkl_data
  except NameError:
    print("The date columns is not defined")
  else:
    pkl_data[date_cols] = pkl_data[date_cols].apply(pd.to_datetime)
    return pkl_data

#!venv/bin/python

import argparse
import yaml

import pandas as pd
from tableschema import Table, Schema, Field

def main(csv_file, schema_file):
    table = Table(csv_file, schema = schema_file)
    
    errors = []
    
    def exc_handler(exc, row_number=None, row_data=None, error_data=None):
        errors.append((exc, row_number, row_data, error_data))

    print("--Read in data--")
    for row in table.iter(exc_handler=exc_handler):
        pass
    
    print("--Errors--")
    print(errors)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-csv", "--csv_file", type = str, help = "csv file name", required = True)
    parser.add_argument("-sch", "--schema_file", type = str, help = "schema file name (json)", required = True)
    args = parser.parse_args()
    main(args.csv_file, schema_file = args.schema_file)

#!venv/bin/python

import re
import json

import yaml
import argparse

from tableschema import Table, Schema

def main(schema_file):

    json_fn = re.sub("\.yaml$", ".json", schema_file)

    # YAML to JSON conversion
    with open(schema_file, "r") as yaml_in, open(json_fn, "w") as json_out:
        yaml_object = yaml.safe_load(yaml_in)
        json.dump(yaml_object, json_out, indent = 4)
    
    # tableschema validation
    schema_object = Schema(json_fn)
    print(schema_object.valid)
    print(schema_object.errors)
    print("json file written to: %s" % json_fn)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-sch", "--schema_file", type = str, help = "schema file name (json)", required = True)
    args = parser.parse_args()
    main(args.schema_file)

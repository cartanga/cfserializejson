# Colfusion json serialization  - EXT JS

## Problem
Serialization to json in coldfusion is simple with serializejson function. 
But, the catch is that the function has following issues - 
- Serializes all queries/structures with capital characters
- No way to limit the serialization except have some util function to perform it before hand
- Query serialization to json not handled in customized way

This project provides a small utility component to acheive the same. 

## Features

Additionally, the helper function provides a way to customize the output according to EXT JS format.
Users could modify it according to their needs for other JS frameworks as needed. 

- **Capitalize**: Instructs if the serialized json should contain keys capitalized (which is the default output from serializejson function)
- **Fields List**: Additional helper function to limit the structure members, thereby limiting json output to only the required members.

Includes MxUnit test cases.
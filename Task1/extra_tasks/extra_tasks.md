# Answers for extra tasks of first task

> Sub-task 1. Read about GitHub Actions. What environment variables can be created?

There's two types of variables:
- Environment variables (Global system environment variables)
- Shell variables (Variables that exists only in running shell instance)

And variable names should meet requirements:
- Should start with Latin letters: a-z or A-Z
- Can contain numbers: 0-9
- Can start with or contain underscore symbol: _

Examples of valid variable names:
- AT
- NOW
- TIME
- GLOBAL_ENVIRONMENT_VARIABLE
- LOCAL_ENVIRONMENT_VARIABLE
- TIME_AFTER_4_HOURS

Examples of invalid variable names:
- 1ST_CHARACTER_IS_NUMBER
- SEPARATED-WITH-DASH-SYMBOL
- ТЕКСТ_НА_КИРИЛЛИЦЕ
- MIX_OF_КИРИЛЛИЦА_AND-LATIN-SYMBOLS
- .HIDDEN_VARIABLES_DON'T_EXIST

----

> Sub-task 2. Create your workflow, what consists of two jobs and contain requirements according the scheme below


Secrets can be created in:
```
Settings > Secrets > Actions > New repository secret
```

# Case 09 - Missing Dependency

## Scenario

A Python application failed to start because one of its required dependencies was missing from the current Python environment.

---

## Symptom

Running:

```bash
python3 app.py
```

returned:

```text
ModuleNotFoundError: No module named 'pendulum'
```

---

## Investigation

Checked whether the dependency was installed:

```bash
python3 -m pip show pendulum
```

Result:

```text
WARNING: Package(s) not found: pendulum
```

This confirmed that the required package was not installed in the current Python environment.

---

## Root Cause

The application depended on the Python package `pendulum`, but the package was missing from the Python environment used to run the application.

---

## Fix

Installed the missing dependency:

```bash
python3 -m pip install pendulum
```

---

## Verification

Verified the package installation:

```bash
python3 -m pip show pendulum
```

Example result:

```text
Name: pendulum
Version: 3.2.0
```

Then ran the application again:

```bash
python3 app.py
```

Output:

```text
Application started successfully.
```

---

## What I Learned

- `ModuleNotFoundError` often indicates a missing Python dependency.
- `python3 -m pip show <package>` can confirm whether a package is installed.
- `python3 -m pip install <package>` installs the dependency for the selected Python interpreter.
- Using `python3 -m pip` is safer than relying on a standalone `pip` command because it reduces the risk of installing packages into the wrong Python environment.
- Dependency fixes should always be verified by rerunning the application.

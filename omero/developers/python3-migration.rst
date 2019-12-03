Migration from OMERO 5.5 (Python 2) to OMERO 5.6 (Python 3)
===========================================================

This page serves as a collection of tips the OME team used to
get through the migration to Python 3. This is not a complete
guide but may serve as a useful starting point.

For more information, please see a dedicated Python 3 page like
http://python-future.org/.

Futurize
--------

Installing `future` from Python 3 is now required for all OMERO
Python components. This library comes with a tool, `futurize`
which will perform many of the basic transformations needed to
migrate Python 2 code to Python 3:

::

    futurize -0 your_file.py

Add `-w` to update the file in place.

`print()`
^^^^^^^^^

The most common transformation needed is adding parentheses around
print statements since print is no longer a keyword.

`dict.keys()`
^^^^^^^^^^^^^

The return value from the `keys()` method of dictionaries is of type
`dict_keys` and no longer has methods like `sort()`. Wrap with a call
to list if you need the previous behavior: `list(my_dict.keys())`.


Strings
-------

One of if not the major hurdle in upgrading from Python 2 to Python 3 is the shift in
strings. In Python 2, there is a separation between `str` and `unicode`. In Python 3,
both of those are like `unicode` (but called `str`) and a new type was introduced:
`bytes`. A good starting places to learn the difference is:

http://python-future.org/compatible_idioms.html?highlight=string#strings-and-bytes

Complicating the matter further is our use of the `future` library, which tries
to help support Python 2 and Python 3 at the same time. Imports including
`past` or `future` should be looked up in the above guide.

What is `str`??
^^^^^^^^^^^^^^^

If nothing special is imported, `str` is the builtin `str` in Py2 (non-unicode) but unicode in Py3.
String literals like "foo" are also of type `str`.

If `unicode_literal` is imported, then "foo" is the same as u"foo" and is `unicode` in Python 2
or just `str` in Python 3.

If `from builtins import str` is imported, then `str` is more like unicode and may fail existing
calls to `isinstance()`.

`isinstance(x, str)`
^^^^^^^^^^^^^^^^^^^^

Since `str` can change its type, this often will not do what you want.
Using `past.builtins.basestring` is generally a good solution, e.g.
`isinstance(x, basestring)`

str(some_variable)
^^^^^^^^^^^^^^^^^^

If you are trying to turn a variable into a string, this may not do what you
want since it might be creating a `unicode`.

This is especially problematic for passing strings to Ice methods, which are
implemented in the C++ and fail spectacularly if they receive non-string
objects (like unicode).

`future.utils.native_str` maintains the previous semantics producing builtin `str` objects.
Native str semantics are especially important when working with Ice, e.g.

::

        ctx = {'omero.group': native_str(groupId)}
        conn.getUpdateService().saveArray(pixels, ctx)

StringIO and open(“file”, “r”)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`StringIO` and `open()` may need replacing with `BytesIO` and `open("file", "rb")` respectively.
This depends on whether or not your code is expecting a stream to be binary.

Regexes
^^^^^^^

Regexes must start with `r""` for raw to prevent escapes from being misinterpreted (e.g. `\d`).


Numerics
--------

`long` no longer exists. Replace `omero.rtypes.wrap(long_value)` with `omero.rtypes.rlong(long_value)`.

Division with `/` now produces a floating point. For example, `choice * int(percent) / 100` no longer
produces an int's in Python 3. Use `//`.

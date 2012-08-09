Testing on Jenkins
==================

This website contains examples which are used by Jenkins to run tests
against OMERO products.

Environment
-----------

Jenkins environment is available :jenkins:`here
<job/OMERO-trunk-components/component=start,label=linux/lastSuccessfulBuild/artifact/src/hudson.log>`.

Your test
---------

::

    class MyTestControl(BaseControl):

        def _configure(self, parser):
            sub = parser.sub()

            parser.add(sub, self.start, "Start")
            parser.add(sub, self.stop, "Stop")
            parser.add(sub, self.status, "Status")

            #
            # Advanced
            #

            unittest = parser.add(sub, self.unittest, "Run tests")
            unittest.add_argument("--config", action="store", help = "ice.config location")
            unittest.add_argument("--test", action="store", help = "Specific test case(-s).")

        def unittest(self, args):
            try:
                ice_config = args.config
                test = args.test
            except:
                self.ctx.die(121, "usage: unittest --config=/path/to/ice.config --test=appname.TestCase --path=/external/path/")
                
            cargs.extend([ "python manage.py", "test"])
            if test:
                cargs.append(test)
            self.set_environ(ice_config)
            rv = self.ctx.call(cargs, cwd = location)

        def set_environ(self, ice_config=None):
            os.environ['ICE_CONFIG'] = ice_config is None and str(self.ctx.dir / "etc" / "ice.config") or str(ice_config)
            os.environ['PATH'] = str(os.environ.get('PATH', '.') + ':' + self.ctx.dir / 'bin')

Jenkins scripts
---------------

If you are executing your tests via **bin/omero myapp unittest**
(settled on component/tools/OmeroPy/src/omero/plugin) $ICE\_CONFIG will
get unset. You will need to pass the file directly to your bin/omero
myapp unittest command.

::

    #OMERO-myapp.sh
    set -e
    set -u
    set -x

    #
    # Run tests
    #
    ./build.py clean

    python bin/omero config set omero.myapp.host '$OMERO_HOST'
    python bin/omero config set omero.myapp.port '$OMERO_PREFIX4064'

    ./build.py
    python dist/bin/omero web unittest --config=$ICE_CONFIG --test=myapp

::

    #OMERO-myapp.bat
    REM
    REM Run tests
    REM
    python build.py clean
    if errorlevel 1 goto ERROR
    python bin/omero config set omero.myapp.host '%OMERO_HOST%'
    if errorlevel 1 goto ERROR
    python bin/omero config set omero.myapp.port '%OMERO_PREFIX%4064'
    if errorlevel 1 goto ERROR
    python build.py
    if errorlevel 1 goto ERROR
    python dist\bin\omero myapp unittest --config=$ICE_CONFIG --test=myapp
    if errorlevel 1 goto ERROR

    exit /b 0
    :ERROR
      echo Failed %ERRORLEVEL%
      exit /b %ERRORLEVEL%

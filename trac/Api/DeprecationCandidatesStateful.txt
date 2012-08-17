Stateful Services Deprecation
=============================

Table of Contents
^^^^^^^^^^^^^^^^^

#. `RenderingEngine (approx 50
   methods) <#RenderingEngineapprox50methods>`_
#. `RawFileStore <#RawFileStore>`_
#. `RawPixelsStore <#RawPixelsStore>`_
#. `SearchService <#SearchService>`_
#. `ThumbnailStore <#ThumbnailStore>`_

As we look to clean up the OMERO API (see
`Omero/GatewayApi </ome/wiki/Omero/GatewayApi>`_) it is proposed to
deprecate various stateful services and provide necessary functionality
via stateless methods. Most clients use the current stateful services in
a stateless fashion, with the exception of the rendering engine.

Begin by documenting current use of the stateful services. For a similar
look at stateless services see
`Api/DeprecationCandidates </ome/wiki/Api/DeprecationCandidates>`_.

RenderingEngine (approx 50 methods)
-----------------------------------

    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    |                                                        | gateway   | plugins   | `OmeroWeb </ome/wiki/OmeroWeb>`_   | Java   | other                             |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | render(planeDef)                                       |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | renderAsPackedInt(planeDef)                            |           |           |                                    |        | script\_utils.py omero\_fuse.py   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | renderAsPackedIntAsRGBA(planeDef)                      |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | renderProjectedAsPackedInt(planeDef)                   |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | renderCompressed(planeDef)                             | gateway   |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | renderProjectedCompressed(alg, t, step, start, stop)   | gateway   |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | lookupPixels(pid)                                      | gateway   |           |                                    |        | script\_utils                     |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | lookupRenderingDef(pid)                                | gateway   |           |                                    |        | script\_utils                     |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | loadRenderingDef(defId)                                | gateway   |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setOverlays(tableId, imgId, rowMap)                    |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | load()                                                 | gateway   |           |                                    |        | script\_utils                     |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setModel(model)                                        | gateway   |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getModel()                                             | gateway   |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getDefaultZ()                                          | gateway   |           | webgateway/views.py                |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getDefaultT()                                          | gateway   |           | webgateway/views.py                |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setDefaultZ()                                          |           |           | webgateway/views.py                |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setDefaultT()                                          |           |           | webgateway/views.py                |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getPixels()                                            | gateway   |           |                                    |        | scripts/Combine\_Images.py        |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getAvailableModels()                                   | gateway   |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getAvailableFamilies()                                 |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setQuantumStrategy(bitRes)                             |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setCodomainInterval(start, end)                        |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getQuantumDef()                                        |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setQuantizationMap(w, family, coef, noiseRed)          |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getChannelFamily(w)                                    |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getChannelNoiseReduction(w)                            |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getChannelStats(w)                                     |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getChannelCurveCoefficient(w)                          |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setChannelWindow(w, start, end)                        | gateway   |           |                                    |        | script\_utils                     |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getChannelWindowStart(w)                               | gateway   |           |                                    |        | Figure\_Scripts                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getChannelWindowEnd(w)                                 | gateway   |           |                                    |        | Figure\_Scripts                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setRGBA(w, r,g,b,a)                                    | gateway   |           |                                    |        | script\_utils, Figure\_Scripts    |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getRGBA(w)                                             | gateway   |           |                                    |        | Figure\_Script                    |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setActive(w, active)                                   | gateway   |           |                                    |        | Figure\_Scripts                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | isActive(w)                                            | gateway   |           | webgateway/views.py                |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | addCodomainMap(mapCtx)                                 |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | updateCodomainMap(mapCtx)                              |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | removeCodomainMap(mapCtx)                              |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | saveCurrentSettings()                                  | gateway   |           |                                    |        | script\_utils.py                  |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | resetDefaults()                                        |           |           |                                    |        | script\_utils, Figure\_Scripts    |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | resetDefaultsNoSave()                                  |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setCompressionLevel(percent)                           | gateway   |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getCompressionLevel()                                  |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | isPixelsTypeSigned()                                   |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getPixelsTypeUpperBound(w)                             |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getPixelsTypeLowerBound(w)                             |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | setZoomLevel(level)                                    |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+
    | getZoomLevel()                                         |           |           |                                    |        |                                   |
    +--------------------------------------------------------+-----------+-----------+------------------------------------+--------+-----------------------------------+

RawFileStore
------------

    +------------------------+-----------+-----------+------------------------------------+-----------+----------------------------------------------------------+
    |                        | gateway   | plugins   | `OmeroWeb </ome/wiki/OmeroWeb>`_   | Java      | other                                                    |
    +------------------------+-----------+-----------+------------------------------------+-----------+----------------------------------------------------------+
    | createRawFileStore()   | gateway   |           |                                    | Insight   | clients.py tables.py populate\_roi.py script\_utils.py   |
    +------------------------+-----------+-----------+------------------------------------+-----------+----------------------------------------------------------+

gateway/init.py

::

    store = self._conn.createRawFileStore()
    store.setFileId(self._obj.file.id.val)
    size = self.getFileSize()
    buf = 2621440
    if size <= buf:
        yield store.read(0,long(size))
    else:
        for pos in range(0,long(size),buf):
            data = None
            if size-pos < buf:
                data = store.read(pos, size-pos)
            else:
                data = store.read(pos, buf)
            yield data
    store.close()

clients.py

::

    prx = self.__sf.createRawFileStore()
    try:
        prx.setFileId(ofile.id.val)
        prx.truncate(size) # ticket:2337
        offset = 0
        while True:
            block = file.read(block_size)
            if not block:
                break
            prx.write(block, offset, len(block))
            offset += len(block)
    finally:
        prx.close()

clients.py

::

    size = ofile.size.val
    offset = 0
    prx = self.__sf.createRawFileStore()

    while (offset+block_size) < size:
        filehandle.write(prx.read(offset, block_size))
        offset += block_size
    filehandle.write(prx.read(offset, (size-offset)))

webclient\_gateway.py

::

    def saveAndReturnFile(self, binary, oFile_id):
        store = self.createRawFileStore()
        store.setFileId(oFile_id);
        pos = 0
        rlen = 0
        for chunk in binary.chunks():
            store.write(chunk, pos, len(chunk))
            pos = pos + rlen
        return store.save()

All functionality of the stateful raw file store (as summarised above)
can be provided by the following stateless methods:

::

    data = readFromFile(fileId, offset, block_size)
    writeToFile(fileId, data, offset, block_size)
    truncateFile(fileId, size)
    originalFile = getObjects("OriginalFile", [fileId]) # not sure what save() does

RawPixelsStore
--------------

    +--------------------------+-----------+-----------+------------------------------------+-----------+--------------------+
    |                          | gateway   | plugins   | `OmeroWeb </ome/wiki/OmeroWeb>`_   | Java      | other              |
    +--------------------------+-----------+-----------+------------------------------------+-----------+--------------------+
    | createRawPixelsStore()   | gateway   |           |                                    | Insight   | script\_utils.py   |
    +--------------------------+-----------+-----------+------------------------------------+-----------+--------------------+

gateway/init.py

::

    def getPixelRange (self):
        """ 
        Returns (min, max) values for the pixels type of this image.
        TODO: Does not handle floats correctly, though.
        @return:    Tuple (min, max)
        """
        pixels_id = self._obj.getPrimaryPixels().getId().val
        rp = self._conn.createRawPixelsStore()
        rp.setPixelsId(pixels_id, True)
        pmax = 2 ** (8 * rp.getByteWidth())
        if rp.isSigned():
            return (-(pmax / 2), pmax / 2 - 1)
        else:
            return (0, pmax-1)

gateway/init.py in getPixelLine()

::

    rp = self._conn.createRawPixelsStore()
    rp.setPixelsId(pixels_id, True)
    for c in channels:
        bw = rp.getByteWidth()
        key = self.LINE_PLOT_DTYPES.get((bw, rp.isFloat(), rp.isSigned()), None)
        plot = array.array(key, axis == 'h' and rp.getRow(pos, z, c, t) or rp.getCol(pos, z, c, t))

script\_util.py (extra lines removed etc)

::

    rawPixelStore = sf.createRawPixelsStore()
    rawPixelStore.setPixelsId(pixelsId, True)
    for theC in range(sizeC):
        for theZ in range(sizeZ):
            for theT in range(sizeT):
                # get and convert plane (not shown)
                rawPixelsStore.setPlane(convertedPlane, theZ, theC, theT)
                # OR use setRow
                for y in range(rowCount):
                    rawPixelsStore.setRow(convertedRow, y, z, c, t)
    rawPixelStore.close()


    rawPixelsStore = session.createRawPixelsStore()
    rawPixelsStore.setPixelsId(pixelsId, True)
    # loop through dimensions, saving planes as tiffs.
    for z in range(sizeZ):
        for c in range(sizeC):
            for t in range(sizeT):
                rawPlane = rawPixelsStore.getPlane(z, c, t)

All functionality of the stateful Raw Pixels Store (represented above)
can be provided by the following stateless methods:

::

    getPlane(pixelsId, z, c, t)
    setPlane(pixelsId, planeData, z, c, t)
    setRow(pixelsId, rowData, y, z, c, t)
    getRow(pixelsId, y, z, c, t)     # for completeness. 

SearchService
-------------

    +-------------------------+-----------+-----------+------------------------------------+-----------+---------+
    |                         | gateway   | plugins   | `OmeroWeb </ome/wiki/OmeroWeb>`_   | Java      | other   |
    +-------------------------+-----------+-----------+------------------------------------+-----------+---------+
    | createSearchService()   | gateway   |           |                                    | Insight   |         |
    +-------------------------+-----------+-----------+------------------------------------+-----------+---------+

gateway.init.py some lines (decorators etc) removed.

::

    search = self.createSearchService()
    if created:
        search.onlyCreatedBetween(created[0], created[1]);
    if text[0] in ('?','*'):
        search.setAllowLeadingWildcard(True)
    rv = []
    for t in types:
        search.onlyType(t)
        search.byFullText(text)
        if search.hasNext():
            rv.extend(map(lambda x: t(self, x), search.results()))
    search.close()

code from various functions in Insight OMERO.gateway.java

::

    SearchPrx service = getSearchService();
    service.setCaseSentivice(context.isCaseSensitive());

    switch (context.getTimeIndex()) {
        case SearchDataContext.CREATION_TIME:
            service.onlyCreatedBetween(start, end);
            break;
        case SearchDataContext.MODIFICATION_TIME:
            service.onlyModifiedBetween(start, end);
            break;
        case SearchDataContext.ANNOTATION_TIME:
            service.onlyAnnotatedBetween(start, end);
    }
    // prepareTextSearch
    if (startWithWildCard(value)) service.setAllowLeadingWildcard(true);
    service.onlyType(Image.class.getName());

    service.bySomeMustNone(fSome, fMust, fNone);

    // handleSearchResult
    if (!service.hasNext()) return r;
    List l = service.results();
    Iterator k = l.iterator();
    while (k.hasNext()) {
        object = (IObject) k.next();
        // ...handle results, remove duplicates etc.
        
    service.clearQueries();
    // may use service again here.. then..
    service.close();

Above functionality might be handled by:

::

    time = "Creation" # or "Annotation" or "Modification"
    results = searchBySomeMustNone(leadingWildCard, caseSensitive, start, stop, time, some, must, none)
    results = searchByFullText(leadingWildCard, caseSensitive, start, stop, time, text)

ThumbnailStore
--------------

    +--------------------------+-----------+-----------+------------------------------------+-----------+---------+
    |                          | gateway   | plugins   | `OmeroWeb </ome/wiki/OmeroWeb>`_   | Java      | other   |
    +--------------------------+-----------+-----------+------------------------------------+-----------+---------+
    | createThumbnailStore()   | gateway   |           |                                    | Insight   |         |
    +--------------------------+-----------+-----------+------------------------------------+-----------+---------+

Used to reset rendering settings in gateway/init.py

::

    tb = self._conn.createThumbnailStore()
    if not tb.setPixelsId(pixels_id):
        tb.resetDefaults()
    tb.close()

prepare

::

    tb = self._conn.createThumbnailStore()
    tb.setPixelsId(pid)
    tb.setRenderingDefId(rdid)   # try catch not shown.

    size = (100, 100)   # or (100,)
    pos = z,t           # or None

    if len(size) == 1:
        if pos is None:
            thumb = tb.getThumbnailByLongestSideDirect
        else:
            thumb = tb.getThumbnailForSectionByLongestSideDirect
    else:
        if pos is None:
            thumb = tb.getThumbnailDirect
        else:
            thumb = tb.getThumbnailForSectionDirect
    args = map(lambda x: rint(x), size)
    if pos is not None:
        args = list(pos) + args
    rv = thumb(*args)

Insight OMEROgateway.java

::

    //getRendering Def for a given pixels set. Used below.
    ThumbnailStorePrx service = getThumbService();
    if (!(service.setPixelsId(pixelsID))) {
        service.resetDefaults();
        service.setPixelsId(pixelsID);
    }


    ThumbnailStorePrx service = getThumbService();
    // set pixelsID as above
    if (userID >= 0) {
        RenderingDef def = getRenderingDef(pixelsID, userID);
        if (def != null) service.setRenderingDefId(def.getId().getValue());
    }
    return service.getThumbnail(omero.rtypes.rint(sizeX), omero.rtypes.rint(sizeY));


    ThumbnailStorePrx service = getThumbService();
    // set pixelsID as above
    return service.getThumbnailByLongestSide(omero.rtypes.rint(maxLength));


    ThumbnailStorePrx service = getThumbService();
    return service.getThumbnailByLongestSideSet(omero.rtypes.rint(maxLength), pixelsIDs);

Simply need to add pixelsId and rDefId to the various methods used above
to create a Stateless thumbnail store.

::

    getThumbnailByLongestSideDirect(pixelsId, rDefId, size)
    getThumbnailForSectionByLongestSideDirect(pixelsId, rDefId, theZ, theT, size)
    getThumbnailDirect(pixelsId, rDefId, sizeX, sizeY)
    getThumbnailForSectionDirect(pixelsId, rDefId, theZ, theT, sizeX, sizeY)

    getThumbnail(pixelsId, rDefId, sizeX, sizeY)
    getThumbnailByLongestSideSet(length, pixelsIDs)   # already stateless! Need rDefIDs?

# Copyright (c) Django Software Foundation and individual contributors.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
#     1. Redistributions of source code must retain the above copyright notice,
#        this list of conditions and the following disclaimer.
#
#     2. Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.
#
#     3. Neither the name of Django nor the names of its contributors may be used
#        to endorse or promote products derived from this software without
#        specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


"""
Sphinx plugins for OMERO documentation.
Based on https://github.com/django/django/blob/stable/1.6.x/docs/_ext/djangodocs.py
"""
import json
import os
import re

from sphinx import addnodes, __version__ as sphinx_ver
from sphinx.builders.html import StandaloneHTMLBuilder
try:
    from sphinx.writers.html import SmartyPantsHTMLTranslator as HTMLTranslator
except:
    from sphinx.writers.html import HTMLTranslator
from sphinx.util.console import bold
from docutils.parsers.rst import Directive

# RE for option descriptions without a '--' prefix
simple_option_desc_re = re.compile(
    r'([-_a-zA-Z0-9]+)(\s*.*?)(?=,\s+(?:/|-|--)|$)')

def setup(app):
    app.add_crossref_type(
        directivename = "property",
        rolename      = "property",
        indextemplate = "%s",
    )

class OMEROHTMLTranslator(HTMLTranslator):
    """
    OMERO-specific reST to HTML tweaks.
    """

    # Don't use border=1, which docutils does by default.
    def visit_table(self, node):
        self.context.append(self.compact_p)
        self.compact_p = True
        self._table_row_index = 0 # Needed by Sphinx
        self.body.append(self.starttag(node, 'table', CLASS='docutils'))

    def depart_table(self, node):
        self.compact_p = self.context.pop()
        self.body.append('</table>\n')

    def visit_desc_parameterlist(self, node):
        self.body.append('(')  # by default sphinx puts <big> around the "("
        self.first_param = 1
        self.optional_param_level = 0
        self.param_separator = node.child_text_separator
        self.required_params_left = sum([isinstance(c, addnodes.desc_parameter)
                                         for c in node.children])

    def depart_desc_parameterlist(self, node):
        self.body.append(')')

    if sphinx_ver < '1.0.8':
        #
        # Don't apply smartypants to literal blocks
        #
        def visit_literal_block(self, node):
            self.no_smarty += 1
            HTMLTranslator.visit_literal_block(self, node)

        def depart_literal_block(self, node):
            HTMLTranslator.depart_literal_block(self, node)
            self.no_smarty -= 1

    # Give each section a unique ID -- nice for custom CSS hooks
    def visit_section(self, node):
        old_ids = node.get('ids', [])
        node['ids'] = ['s-' + i for i in old_ids]
        node['ids'].extend(old_ids)
        HTMLTranslator.visit_section(self, node)
        node['ids'] = old_ids

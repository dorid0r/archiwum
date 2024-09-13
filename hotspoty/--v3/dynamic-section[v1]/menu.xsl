<iaixsl:if test="navigation2/item">
    <iaixsl:variable name="cats">
        <iaixsl:text><![CDATA[[]]></iaixsl:text>
            <iaixsl:for-each select="navigation2/item">
                <iaixsl:if test="item">
                    <iaixsl:for-each select="item">
                        <iaixsl:if test="item">
                            <iaixsl:for-each select="item">
                                <iaixsl:if test="item">
                                    <iaixsl:for-each select="item">
                                        <iaixsl:text><![CDATA[{]]></iaixsl:text>
                                        <iaixsl:text><![CDATA['id']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:value-of select="@ni"/><iaixsl:text><![CDATA[,]]></iaixsl:text>
                                        <iaixsl:text><![CDATA['name']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:text><![CDATA[']]></iaixsl:text><iaixsl:value-of select="@name"/><iaixsl:text><![CDATA[',]]></iaixsl:text>
                                        <iaixsl:text><![CDATA['url']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:text><![CDATA[']]></iaixsl:text><iaixsl:value-of select="@link"/><iaixsl:text><![CDATA[']]></iaixsl:text>
                                        <iaixsl:text><![CDATA[},]]></iaixsl:text>
                                    </iaixsl:for-each>
                                </iaixsl:if>
                                <iaixsl:text><![CDATA[{]]></iaixsl:text>
                                <iaixsl:text><![CDATA['id']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:value-of select="@ni"/><iaixsl:text><![CDATA[,]]></iaixsl:text>
                                <iaixsl:text><![CDATA['name']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:text><![CDATA[']]></iaixsl:text><iaixsl:value-of select="@name"/><iaixsl:text><![CDATA[',]]></iaixsl:text>
                                <iaixsl:text><![CDATA['url']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:text><![CDATA[']]></iaixsl:text><iaixsl:value-of select="@link"/><iaixsl:text><![CDATA[']]></iaixsl:text>
                                <iaixsl:text><![CDATA[},]]></iaixsl:text>
                            </iaixsl:for-each>
                        </iaixsl:if>
                        <iaixsl:text><![CDATA[{]]></iaixsl:text>
                        <iaixsl:text><![CDATA['id']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:value-of select="@ni"/><iaixsl:text><![CDATA[,]]></iaixsl:text>
                        <iaixsl:text><![CDATA['name']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:text><![CDATA[']]></iaixsl:text><iaixsl:value-of select="@name"/><iaixsl:text><![CDATA[',]]></iaixsl:text>
                        <iaixsl:text><![CDATA['url']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:text><![CDATA[']]></iaixsl:text><iaixsl:value-of select="@link"/><iaixsl:text><![CDATA[']]></iaixsl:text>
                        <iaixsl:text><![CDATA[},]]></iaixsl:text>
                    </iaixsl:for-each>
                </iaixsl:if>
                <iaixsl:text><![CDATA[{]]></iaixsl:text>
                <iaixsl:text><![CDATA['id']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:value-of select="@ni"/><iaixsl:text><![CDATA[,]]></iaixsl:text>
                <iaixsl:text><![CDATA['name']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:text><![CDATA[']]></iaixsl:text><iaixsl:value-of select="@name"/><iaixsl:text><![CDATA[',]]></iaixsl:text>
                <iaixsl:text><![CDATA['url']]></iaixsl:text><iaixsl:text><![CDATA[:]]></iaixsl:text><iaixsl:text><![CDATA[']]></iaixsl:text><iaixsl:value-of select="@link"/><iaixsl:text><![CDATA[']]></iaixsl:text>
                <iaixsl:text><![CDATA[}]]></iaixsl:text><iaixsl:if test="not(position()=last())"><iaixsl:text><![CDATA[,]]></iaixsl:text></iaixsl:if>
            </iaixsl:for-each>
        <iaixsl:text><![CDATA[]]]></iaixsl:text>
    </iaixsl:variable>
    <script>
        const categoryData = <iaixsl:value-of select="$cats"/>
    </script>
</iaixsl:if>

<?xml version="1.0" encoding="UTF-8"?><iai:component><iai:componentsdata><cdata-start/>
    <!-- SETTINGS -->
    <iaixsl:variable name="param_search"></iaixsl:variable>
    <iaixsl:variable name="param_search_gfx"></iaixsl:variable>
    <iaixsl:variable name="versions_search">true</iaixsl:variable>
    <iaixsl:variable name="var_yousave_search"></iaixsl:variable>
    <iaixsl:variable name="var_net_prices_search"><iaixsl:if test="/shop/page/@price_type = 'net'"><iaixsl:value-of select="$priceTypeText"/></iaixsl:if></iaixsl:variable>
    <iaixsl:variable name="var_gross_prices_search"><iaixsl:if test="/shop/page/@price_type = 'gross'"><iaixsl:value-of select="$priceTypeText"/></iaixsl:if></iaixsl:variable>
    <iaixsl:variable name="var_b2b_search"></iaixsl:variable>
    <iaixsl:variable name="traitsDataID">2577</iaixsl:variable>

    <!-- TEXTS -->
    <iaixsl:variable name="addcompare_txt"></iaixsl:variable>

    <iaixsl:if test="/shop/page/products/display_mode/@active = 'normal'">

        <iaixsl:if test="navigation/descendant::item[@ni=/shop/navigation/current/@ni]/@gfx_active or navigation2/descendant::item[@ni=/shop/navigation/current/@ni]/@gfx_active">
            <h2 class="headline"><span class="headline__name"><iai:variable vid="Wszystkie produkty"/></span></h2>
        </iaixsl:if>
        <section id="search" class="search products">
            <ul class="search__grid">
                <li data-grid="1" class="d-md-none search__grid__view --grid-1"></li>
                <li data-grid="2" class="d-md-none search__grid__view --grid-2"></li>
                <li data-grid="3" class="d-none d-md-block search__grid__view --grid-3"></li>
                <li data-grid="4" class="d-none d-md-block search__grid__view --grid-4"></li>
                <iaixsl:if test="count(/shop/page/products/navigation/filtering/filter)">
                    <li class="s_paging__item --filters">
                        <a class="filters__button" href="#menu_filter">
                            <iai:variable vid="Filtry"/>
                        </a>
                    </li>  
                </iaixsl:if>
            </ul>
            <iaixsl:for-each select="/shop/page/products/product">
                <iaixsl:if test="position() = 5 and (/shop/page/products/navigation/item[@type='current']/@counter = 1) and contains(/shop/page/products/additional/category_list/description, '#categoryDesc')">
                    <iaixsl:value-of disable-output-escaping="yes" select="substring-after(/shop/page/products/additional/category_list/description, '#categoryDesc')"/>
                </iaixsl:if>
                <iaixsl:if test="count(/shop/commercial_banner3) &gt; 0">
                  <iaixsl:if test="not(count(/shop/commercial_banner3/link) > position())">
                    <iaixsl:choose>
                      <iaixsl:when test="position() = 5"><iaixsl:for-each select="/shop/commercial_banner3/link[position() = 1]"><iaixsl:value-of disable-output-escaping="yes" select="html"/></iaixsl:for-each></iaixsl:when>
                      <iaixsl:when test="position() = 20"><iaixsl:for-each select="/shop/commercial_banner3/link[position() = 2]"><iaixsl:value-of disable-output-escaping="yes" select="html"/></iaixsl:for-each></iaixsl:when>
                      <iaixsl:otherwise></iaixsl:otherwise>
                    </iaixsl:choose>
                  </iaixsl:if>
                </iaixsl:if>
                <div class="product ">
                    <iaixsl:attribute name="data-product_id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
                    <iaixsl:attribute name="data-product_page"><iaixsl:value-of select="/shop/page/products/navigation/item[@type = 'current']/@counter - 1"/></iaixsl:attribute>
                    <iaixsl:if test="position() = 1">
                        <iaixsl:attribute name="data-product_first"><![CDATA[true]]></iaixsl:attribute>
                    </iaixsl:if>
                    <iaixsl:if test="sizes/availability/@status = 'disable'">
                        <iaixsl:attribute name="data-product_disable"><![CDATA[true]]></iaixsl:attribute>
                    </iaixsl:if>
                    <!-- SALESmanago NextGen -->
                    <iaixsl:if test="/shop/page/@ecommerce_module_class">
                        <iaixsl:attribute name="class">
                            product col-6 col-sm-4 py-3

                            <iaixsl:variable name="ecommerce_module_separator"><![CDATA[{productId}]]></iaixsl:variable>

                            <iaixsl:variable name="ecommerce_module_class_before"><iaixsl:value-of select="substring-before(/shop/page/@ecommerce_module_class, $ecommerce_module_separator)"/></iaixsl:variable>
                            <iaixsl:variable name="ecommerce_module_class_after"><iaixsl:value-of select="substring-after(/shop/page/@ecommerce_module_class, $ecommerce_module_separator)"/></iaixsl:variable>

                            <iaixsl:value-of select="$ecommerce_module_class_before"/><iaixsl:value-of select="@id"/><iaixsl:value-of select="$ecommerce_module_class_after"/>
                        </iaixsl:attribute>
                    </iaixsl:if>

                    <!-- YOUSAVE - aktywowane literałem label oszczędzasz XXX -->
                    <iaixsl:if test="$var_yousave_search and not($var_yousave_search = '') and price/@yousave_formatted != ''">
                        <div class="product__yousave">
                            <span class="product__yousave --label"><iaixsl:value-of select="$var_yousave_search"/></span>
                            <span class="product__yousave --value"><iaixsl:value-of select="price/@yousave_formatted"/></span>
                        </div>
                    </iaixsl:if>
                    <a href="#add_favorite" class="product__favorite">
                        <iaixsl:attribute name="data-product-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
                        <i class="icon-star-outline"></i>
                    </a>

                    <!-- IKONA PRODUKTU -->
                    <a class="product__icon d-flex justify-content-center align-items-center">
                        <iaixsl:attribute name="data-product-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
                        <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
                        <iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
                        <iaixsl:if test="traits/trait/@groupid = $traitsDataID">
                        <div class="product__counter">
                            <iaixsl:attribute name="counterDate">
                                <iaixsl:value-of select="traits/trait/@traitdescription"/>
                            </iaixsl:attribute>
                        </div>
                        </iaixsl:if>
                        <picture>
                            <source width="126" height="126">
                                <iaixsl:attribute name="media"><![CDATA[(max-width: 420px)]]></iaixsl:attribute>
                                <iaixsl:choose>
                                    <iaixsl:when test="position() &gt; 2">
                                        <iaixsl:attribute name="data-srcset"><iaixsl:value-of disable-output-escaping="yes" select="icon_small"/></iaixsl:attribute>
                                    </iaixsl:when>
                                    <iaixsl:otherwise>
                                        <iaixsl:attribute name="srcset"><iaixsl:value-of disable-output-escaping="yes" select="icon_small"/></iaixsl:attribute>
                                    </iaixsl:otherwise>
                                </iaixsl:choose>
                            </source>
                            <img src="/gfx/pol/loader.gif?r=1645454563" width="336" height="336">
                                <iaixsl:attribute name="alt"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
                                <iaixsl:choose>
                                    <iaixsl:when test="position() &gt; 2">
                                        <iaixsl:attribute name="class"><![CDATA[b-lazy]]></iaixsl:attribute>
                                        <iaixsl:attribute name="data-src"><iaixsl:value-of disable-output-escaping="yes" select="icon"/></iaixsl:attribute>
                                    </iaixsl:when>
                                    <iaixsl:otherwise>
                                        <iaixsl:attribute name="src"><iaixsl:value-of disable-output-escaping="yes" select="icon"/></iaixsl:attribute>
                                    </iaixsl:otherwise>
                                </iaixsl:choose>
                            </img>
                        </picture>

                        <!-- LABEL -->
                        <iaixsl:variable name="productUnavailable"><iai:variable vid="Chwilowo niedostępny"/></iaixsl:variable>
                        <iaixsl:choose>
                            <iaixsl:when test="not($productUnavailable = '') and sizes/availability/@status = 'disable'">
                                <strong class="label_icons label_icons_search">
                                    <span class="label --disable">
                                        <iaixsl:value-of select="$productUnavailable"/>
                                    </span>
                                </strong>
                            </iaixsl:when>
                            <iaixsl:when test="@promo or @new or @bestseller or @discount or (@distinguished and not(@bestseller and @discount)) or (traits/trait[@groupid = '11193'])">
                                <strong class="label_icons label_icons_search">
                                    <iaixsl:if test="traits/trait[@groupid = '11193']">
                                        <iaixsl:for-each select="traits/trait[@groupid = '11193']">
                                            <span class="label --trait">
                                                <iaixsl:value-of select="@traitlongdescription"/>
                                            </span>                                    
                                        </iaixsl:for-each>
                                    </iaixsl:if>                                        
                                    <iaixsl:if test="@promo">
                                        <span class="label --promo">
                                            <iai:variable vid="W promocji"/>
                                        </span>
                                    </iaixsl:if>
                                    <iaixsl:if test="@new">
                                        <span class="label --new">
                                            <iai:variable vid="Nowość"/>
                                        </span>
                                    </iaixsl:if>
                                    <iaixsl:choose>
                                        <iaixsl:when test="@promo and @new">
                                        </iaixsl:when>
                                        <iaixsl:when test="@promo or @new">
                                            <iaixsl:choose>
                                                <iaixsl:when test="@bestseller">
                                                    <span class="label --bestseller">
                                                        <iai:variable vid="Nasz bestseller"/>
                                                    </span>
                                                </iaixsl:when>
                                                <iaixsl:when test="@discount">
                                                    <span class="label --discount">
                                                        <iai:variable vid="Przecena"/>
                                                    </span>
                                                </iaixsl:when>
                                                <iaixsl:when test="@distinguished">
                                                    <span class="label --distinguished">
                                                        <iai:variable vid="Polecany"/>
                                                    </span>
                                                </iaixsl:when>
                                            </iaixsl:choose>
                                        </iaixsl:when>
                                        <iaixsl:otherwise>
                                            <iaixsl:if test="@bestseller">
                                                <span class="label --bestseller">
                                                    <iai:variable vid="Nasz bestseller"/>
                                                </span>
                                            </iaixsl:if>
                                            <iaixsl:if test="@discount">
                                                <span class="label --discount">
                                                    <iai:variable vid="Przecena"/>
                                                </span>
                                            </iaixsl:if>
                                            <iaixsl:if test="@distinguished and not(@bestseller and @discount)">
                                                <span class="label --distinguished">
                                                    <iai:variable vid="Polecany"/>
                                                </span>
                                            </iaixsl:if>
                                        </iaixsl:otherwise>
                                    </iaixsl:choose>
                                </strong>
                            </iaixsl:when>
                        </iaixsl:choose>
                    </a>
                
                    <div class="product__details">
                        <!-- PRODUCENT -->
                        <iaixsl:if test="(firm/@name) and (firm/@id != '0')">
                        <div class="producer">
                            <a class="brand">
                                <iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="firm/@name"/></iaixsl:attribute>
                                <iaixsl:attribute name="href"><iaixsl:value-of disable-output-escaping="yes" select="firm/@productslink"/></iaixsl:attribute>
                                <iaixsl:value-of disable-output-escaping="yes" select="firm/@name"/>
                            </a>
                        </div>
                        </iaixsl:if>
                        <!-- NAZWA PRODUKTU -->
                        <h3>
                            <a class="product__name">
                                <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
                                <iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
                                <iaixsl:value-of disable-output-escaping="yes" select="name"/>
                            </a>
                        </h3>

                        <!-- CENA -->
                        <iaixsl:choose>
                            <!-- Cena netto -->
                            <iaixsl:when test="$var_net_prices_search and not($var_net_prices_search = '')">
                                <div class="product__prices">
                                    <iaixsl:choose>
                                        <iaixsl:when test="(sizes/prices/@minprice_net_formatted != sizes/prices/@maxprice_net_formatted) or (sizes/prices/@minprice_unit_formatted != sizes/prices/@maxprice_unit_formatted)">
                                            <iaixsl:choose>
                                                <iaixsl:when test="(sizes/prices/@size_min_maxprice_net_formatted != sizes/prices/@size_max_maxprice_net_formatted) or (sizes/prices/@size_min_maxprice_unit_formatted != sizes/prices/@size_max_maxprice_unit_formatted)">
                                                    <del class="price --max">
                                                        <iaixsl:choose>
                                                            <iaixsl:when test="sizes/prices/@size_min_maxprice_unit_formatted">
                                                                <span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_unit_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_unit_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
                                                            </iaixsl:when>
                                                            <iaixsl:otherwise>
                                                                <span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_net_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_net_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
                                                            </iaixsl:otherwise>
                                                        </iaixsl:choose>
                                                    </del>
                                                </iaixsl:when>

                                                <iaixsl:when test="sizes/size/price/@srp_net != '' and sizes/size/price/@srp != sizes/size/price/@value">
                                                    <del class="price --max">
                                                        <iaixsl:value-of select="sizes/size/price/@srp_net_formatted"/>
                                                    </del>
                                                </iaixsl:when>
                                            </iaixsl:choose>
                                            <strong class="price">
                                                
                                                <iaixsl:choose>
                                                    <iaixsl:when test="sizes/prices/@minprice_unit_formatted">
                                                        <iaixsl:value-of select="sizes/prices/@minprice_unit_formatted"/>
                                                    </iaixsl:when>
                                                    <iaixsl:otherwise>
                                                        <iaixsl:value-of select="sizes/prices/@minprice_net_formatted"/>
                                                    </iaixsl:otherwise>
                                                </iaixsl:choose>
                                                    - 
                                                <iaixsl:choose>
                                                    <iaixsl:when test="sizes/prices/@maxprice_unit_formatted">
                                                        <iaixsl:value-of select="sizes/prices/@maxprice_unit_formatted"/>
                                                    </iaixsl:when>
                                                    <iaixsl:otherwise>
                                                        <iaixsl:value-of select="sizes/prices/@maxprice_net_formatted"/>
                                                    </iaixsl:otherwise>
                                                </iaixsl:choose>

                                                <!-- <iaixsl:if test="sizes/prices/@minprice_unit_formatted">
                                                    <iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby" /><iaixsl:text><![CDATA[ ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" />
                                                </iaixsl:if> -->
                                                <span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
                                            </strong>
                                        </iaixsl:when>
                                        <iaixsl:when test="price/@price_net = 0 and not(/shop/basket/@wholesaler = 'true') and $var_b2b_search and not($var_b2b_search = '')">
                                            <a class="price --hurt">
                                                <iaixsl:attribute name="title"><iaixsl:value-of select="$var_b2b_search"/></iaixsl:attribute>
                                                <iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/signin/@url"/></iaixsl:attribute>
                                                <iaixsl:value-of select="$var_b2b_search"/>
                                            </a>
                                        </iaixsl:when>

                                        <iaixsl:when test="(sizes/prices/@minprice_net = 0) and not(price/@points)">
                                            <a class="price --phone">
                                                <iaixsl:attribute name="title"><iai:variable vid="Kliknij, by przejść do formularza kontaktu"/></iaixsl:attribute>
                                                <iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/contact/@url"/></iaixsl:attribute>
                                                <iai:variable vid="Cena na telefon"/>
                                            </a>
                                        </iaixsl:when>
                                        <iaixsl:otherwise>
                                            <iaixsl:choose>
                                                <iaixsl:when test="price/@maxprice_net or price/@maxprice_unit">
                                                    <del class="price --max">
                                                        
                                                        <iaixsl:choose>
                                                            <iaixsl:when test="price/@maxprice_unit_formatted">
                                                                <iaixsl:value-of select="price/@maxprice_unit_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
                                                            </iaixsl:when>
                                                            <iaixsl:otherwise>
                                                                <iaixsl:value-of select="price/@maxprice_net_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
                                                            </iaixsl:otherwise>
                                                        </iaixsl:choose>
                                                    </del>
                                                </iaixsl:when>
                                                <iaixsl:when test="sizes/size/price/@srp_net != '' and sizes/size/price/@srp != sizes/size/price/@value">
                                                    <del class="price --max">
                                                        <iaixsl:value-of select="sizes/size/price/@srp_net_formatted"/>
                                                    </del>
                                                </iaixsl:when>
                                            </iaixsl:choose>
                                            <strong class="price">
                                                <iaixsl:choose>
                                                    <iaixsl:when test="price/@price_unit_net_formatted">
                                                        <iaixsl:value-of select="price/@price_unit_net_formatted"/>
                                                        <!-- <iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby" /><iaixsl:text><![CDATA[ ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" /> -->
                                                    </iaixsl:when>
                                                    <iaixsl:otherwise>
                                                        <iaixsl:value-of select="price/@price_net_formatted"/>
                                                    </iaixsl:otherwise>
                                                </iaixsl:choose>
                                                <span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
                                            </strong>

                                            <!-- <iaixsl:if test="price/@points">
                                        <iai:variable vid="TXT_111232_comma" description="przecinek między cenami"><![CDATA[]]></iai:variable><span class="price points"><iaixsl:value-of select="price/@points"/><span class="currency"><iai:variable vid="TXT_111232_points" description="PKT"><![CDATA[pkt]]></iai:variable></span></span>
                                            </iaixsl:if> -->

                                        </iaixsl:otherwise>
                                    </iaixsl:choose>

                                    <!-- CENA ZA KILO -->
                                    <iaixsl:if test="price/@unit_converted_price_net_formatted"><small class="price --convert"><iaixsl:value-of select="price/@unit_converted_price_net_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span></small>
                                    </iaixsl:if>

                                    <!-- LABEL -->
                                    <iaixsl:if test="sizes/size/price/@srp_diff_percent">
                                        <div class="diff__percent">
                                            <span>- <iaixsl:value-of select="sizes/size/price/@srp_diff_percent"/> %</span>
                                        </div>
                                    </iaixsl:if>
                                </div>
                            </iaixsl:when>
                            <!-- Cena detaliczna -->
                            <iaixsl:otherwise>
                                <div class="product__prices">
                                    <iaixsl:choose>
                                        <iaixsl:when test="(sizes/prices/@minprice_formatted != sizes/prices/@maxprice_formatted) or (sizes/prices/@minprice_unit_formatted != sizes/prices/@maxprice_unit_formatted)">
                                            <iaixsl:choose>
                                                <iaixsl:when test="(sizes/prices/@size_min_maxprice_formatted != sizes/prices/@size_max_maxprice_formatted) or (sizes/prices/@size_min_maxprice_unit_formatted != sizes/prices/@size_max_maxprice_unit_formatted)">
                                                    <del class="price --max">
                                                        <iaixsl:choose>
                                                            <iaixsl:when test="sizes/prices/@size_min_maxprice_unit_formatted">
                                                                <span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_unit_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_unit_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
                                                            </iaixsl:when>
                                                            <iaixsl:otherwise>
                                                                <span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
                                                            </iaixsl:otherwise>
                                                        </iaixsl:choose>
                                                    </del>
                                                </iaixsl:when>

                                                <iaixsl:when test="sizes/size/price/@srp_net != '' and sizes/size/price/@srp != sizes/size/price/@value">
                                                    <del class="price --max">
                                                        <iaixsl:value-of select="sizes/size/price/@srp_formatted"/>
                                                    </del>
                                                </iaixsl:when>
                                            </iaixsl:choose>
                                            <strong class="price">
                                                
                                                <iaixsl:choose>
                                                    <iaixsl:when test="sizes/prices/@minprice_unit_formatted">
                                                        <iaixsl:value-of select="sizes/prices/@minprice_unit_formatted"/>
                                                    </iaixsl:when>
                                                    <iaixsl:otherwise>
                                                        <iaixsl:value-of select="sizes/prices/@minprice_formatted"/>
                                                    </iaixsl:otherwise>
                                                </iaixsl:choose>
                                                    - 
                                                <iaixsl:choose>
                                                    <iaixsl:when test="sizes/prices/@maxprice_unit_formatted">
                                                        <iaixsl:value-of select="sizes/prices/@maxprice_unit_formatted"/>
                                                    </iaixsl:when>
                                                    <iaixsl:otherwise>
                                                        <iaixsl:value-of select="sizes/prices/@maxprice_formatted"/>
                                                    </iaixsl:otherwise>
                                                </iaixsl:choose>

                                                <!-- <iaixsl:if test="sizes/prices/@minprice_unit_formatted">
                                                    <iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby" /><iaixsl:text><![CDATA[ ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" />
                                                </iaixsl:if> -->
                                                <span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
                                            </strong>
                                        </iaixsl:when>

                                        <iaixsl:when test="(sizes/prices/@minprice = 0) and not(price/@points)">
                                            <a class="price --phone">
                                                <iaixsl:attribute name="title"><iai:variable vid="Kliknij, by przejść do formularza kontaktu"/></iaixsl:attribute>
                                                <iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/contact/@url"/></iaixsl:attribute>
                                                <iai:variable vid="Cena na telefon"/>
                                            </a>
                                        </iaixsl:when>
                                        <iaixsl:otherwise>
                                            <iaixsl:choose>
                                                <iaixsl:when test="price/@maxprice or price/@maxprice_unit">
                                                    <del class="price --max">
                                                        
                                                        <iaixsl:choose>
                                                            <iaixsl:when test="price/@maxprice_unit_formatted">
                                                                <iaixsl:value-of select="price/@maxprice_unit_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
                                                            </iaixsl:when>
                                                            <iaixsl:otherwise>
                                                                <iaixsl:value-of select="price/@maxprice_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
                                                            </iaixsl:otherwise>
                                                        </iaixsl:choose>
                                                    </del>
                                                </iaixsl:when>

                                                <iaixsl:when test="sizes/size/price/@srp_net != '' and sizes/size/price/@srp != sizes/size/price/@value">
                                                    <del class="price --max">
                                                        <iaixsl:value-of select="sizes/size/price/@srp_formatted"/>
                                                    </del>
                                                </iaixsl:when>
                                            </iaixsl:choose>
                                            <strong class="price">
                                                <iaixsl:choose>
                                                    <iaixsl:when test="price/@price_unit_formatted">
                                                        <iaixsl:value-of select="price/@price_unit_formatted"/>
                                                        <!-- <iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby" /><iaixsl:text><![CDATA[ ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" /> -->
                                                    </iaixsl:when>
                                                    <iaixsl:otherwise>
                                                        <iaixsl:value-of select="sizes/prices/@minprice_formatted"/>
                                                        <!-- <span class="price__unit"><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" /></span> -->
                                                    </iaixsl:otherwise>
                                                </iaixsl:choose>
                                                <span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
                                            </strong>

                                            <!-- <iaixsl:if test="price/@yousave_percent">
                                                    <span class="promo__percent">-<iaixsl:value-of select="price/@yousave_percent"/>%</span>
                                            </iaixsl:if> -->

                                            <!-- <iaixsl:if test="price/@points">
                                                <iai:variable vid="TXT_111232_comma" description="przecinek między cenami"><![CDATA[]]></iai:variable><span class="price points"><iaixsl:value-of select="price/@points"/><span class="currency"><iai:variable vid="TXT_111232_points" description="PKT"><![CDATA[pkt]]></iai:variable></span></span>
                                            </iaixsl:if> -->

                                        </iaixsl:otherwise>
                                    </iaixsl:choose>

                                    <!-- CENA ZA KILO -->
                                    <iaixsl:if test="price/@unit_converted_price_formatted"><small class="price --convert"><iaixsl:value-of select="price/@unit_converted_price_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span></small>
                                    </iaixsl:if>

                                    <!-- LABEL -->
                                    <iaixsl:if test="sizes/size/price/@srp_diff_percent">
                                        <div class="diff__percent">
                                            <span>- <iaixsl:value-of select="sizes/size/price/@srp_diff_percent"/> %</span>
                                        </div>
                                    </iaixsl:if>
                                </div>
                            </iaixsl:otherwise>
                        </iaixsl:choose>

                        <!-- DO PORÓWNANIA -->
                        <div class="product__compare">
                            <iaixsl:if test="/shop/compare/@active = 'y' and $addcompare_txt">
                                <iaixsl:attribute name="class"><![CDATA[product__compare --has-child]]></iaixsl:attribute>

                                <iaixsl:choose>
                                    <iaixsl:when test="@id = /shop/compare/product/@id">
                                        <a class="product__compare_item --remove btn" rel="nofollow">
                                            <iaixsl:attribute name="href"><iaixsl:choose><iaixsl:when test="/shop/action/settings/@url"><iaixsl:value-of select="/shop/action/settings/@url"/></iaixsl:when><iaixsl:otherwise><![CDATA[settings.php]]></iaixsl:otherwise></iaixsl:choose><![CDATA[?comparers=remove&amp;product=]]><iaixsl:value-of select="@id"/></iaixsl:attribute>
                                            <iaixsl:attribute name="title"><iai:variable vid="Kliknij, aby usunąć produkt z porównywarki"/></iaixsl:attribute>
                                            - <iai:variable vid="Usuń z porównania"/>
                                        </a>
                                    </iaixsl:when>
                                    <iaixsl:otherwise>
                                        <a class="product__compare_item --add btn" rel="nofollow">
                                            <iaixsl:attribute name="href"><iaixsl:choose><iaixsl:when test="/shop/action/settings/@url"><iaixsl:value-of select="/shop/action/settings/@url"/></iaixsl:when><iaixsl:otherwise><![CDATA[settings.php]]></iaixsl:otherwise></iaixsl:choose><![CDATA[?comparers=add&amp;product=]]><iaixsl:value-of select="@id"/></iaixsl:attribute>
                                            <iaixsl:attribute name="title"><iai:variable vid="Kliknij, aby dodać produkt do porównania"/></iaixsl:attribute>
                                            <iaixsl:value-of select="$addcompare_txt"/>
                                        </a>
                                    </iaixsl:otherwise>
                                </iaixsl:choose>
                            </iaixsl:if>
                        </div>

                        <div class="product__sizes">
                            <iaixsl:if test="sizes/size/@type = 'onesize' or sizes/size/@type = 'uniw'">
                                <iaixsl:attribute name="style"><![CDATA[display:none;]]></iaixsl:attribute>
                            </iaixsl:if>
                            <div class="product__sizes__sub">
                                <iaixsl:for-each select="sizes/size">
                                    <iaixsl:choose>
                                        <iaixsl:when test="(@amount &gt; 0) or (@amount = '-1')">
                                            <a class="product__sizes__button">
                                                <iaixsl:attribute name="data-type"><iaixsl:value-of disable-output-escaping="yes" select="@type"/></iaixsl:attribute>
                                                <iaixsl:value-of disable-output-escaping="yes" select="@description"/>
                                            </a>
                                        </iaixsl:when>
                                        <iaixsl:otherwise>
                                        <a class="product__sizes__button --disabled">
                                            <iaixsl:attribute name="data-type"><iaixsl:value-of disable-output-escaping="yes" select="@type"/></iaixsl:attribute>
                                            <iaixsl:value-of disable-output-escaping="yes" select="@description"/>
                                        </a>
                                        </iaixsl:otherwise>
                                    </iaixsl:choose>
                                </iaixsl:for-each>
                            </div>
                        </div>

                        <!-- WARIANTY I ROZMIARY -->
                        <iaixsl:if test="not($versions_search)">
                            <iaixsl:if test="(count(versions/version[@gfx_small]) &gt; 1 and count(versions/version) = count(versions/version[@gfx_small])) or (sizes/size/@type and not(sizes/size/@type='uniw'))">
                                    <div class="product__details py-1 px-3">
                                            <iaixsl:if test="sizes/size/@type and not(sizes/size/@type='uniw')">
                                                    <div class="product__sizes mb-1">
                                                            <label class="product__size --label"><iai:variable vid="Rozmiar"/>:</label>
                                                            <iaixsl:for-each select="sizes/size">
                                                                    <span class="product__size"><iaixsl:value-of select="@description"/></span>
                                                            </iaixsl:for-each>
                                                    </div>
                                            </iaixsl:if>

                                            <iaixsl:if test="count(versions/version/@gfx_small) &gt; 1">
                                                    <div class="product__versions mx-n1">
                                                            <iaixsl:for-each select="versions/version">
                                                                    <a class="product__version">
                                                                            <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
                                                                            <img>
                                                                                    <iaixsl:attribute name="src"><iaixsl:value-of select="@gfx_small"/></iaixsl:attribute>
                                                                                    <iaixsl:attribute name="alt"><iaixsl:value-of select="@name"/></iaixsl:attribute>
                                                                            </img>
                                                                    </a>
                                                            </iaixsl:for-each>
                                                    </div>
                                            </iaixsl:if>
                                    </div>
                            </iaixsl:if>
                        </iaixsl:if>

                        <!-- PARAMETRY -->
                        <iaixsl:if test="not($param_search)">
                            <iaixsl:if test="traits/trait[not(@gfx)] and traits/trait[not(contains(@groupdescription, 'gs1:'))]">
                                <div class="product__traits d-none mt-2">
                                    <ul>
                                        <iaixsl:for-each select="traits/trait[not(@gfx)]">
                                            <iaixsl:if test="not(@groupid = preceding-sibling::trait/@groupid) and not(contains(@groupdescription, 'gs1:'))">
                                                <li class="trait">
                                                    <span class="trait__name"><iaixsl:value-of select="@groupdescription"/>: </span>
                                                    <div class="trait__values">
                                                        <a class="trait__value"><iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute><iaixsl:value-of select="@traitdescription"/></a>
                                                        <iaixsl:if test="@groupid = following-sibling::trait/@groupid">
                                                            <iaixsl:variable name="temporaryGroup"><iaixsl:value-of select="@groupid"/></iaixsl:variable><iaixsl:for-each select="following-sibling::trait[(@groupid = $temporaryGroup)]">, <a class="trait__value"><iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute><iaixsl:value-of select="@traitdescription"/></a></iaixsl:for-each>
                                                        </iaixsl:if>
                                                    </div>
                                                </li>
                                            </iaixsl:if>
                                        </iaixsl:for-each>
                                    </ul>
                                </div>
                            </iaixsl:if>
                        </iaixsl:if>

                        <!-- PARAMETRY GRAFICZNY -->
                        <iaixsl:if test="not($param_search_gfx)">
                            <iaixsl:if test="traits/trait[@gfx2]">
                                <div class="product__traits --gfx my-2 mb-md-0">
                                    <ul>
                                        <iaixsl:for-each select="traits/trait[@gfx2]">
                                            <li class="trait">
                                                <a class="trait__gfx">
                                                    <iaixsl:attribute name="title"><iaixsl:value-of select="@groupdescription"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="@traitdescription"/></iaixsl:attribute>
                                                    <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
                                                    <img class="trait__img">
                                                        <iaixsl:attribute name="src"><iaixsl:value-of select="@gfx2"/></iaixsl:attribute>
                                                        <iaixsl:attribute name="alt"><iaixsl:value-of select="@traitdescription"/></iaixsl:attribute>
                                                    </img>
                                                </a>
                                            </li>
                                        </iaixsl:for-each>
                                    </ul>
                                </div>
                            </iaixsl:if>
                        </iaixsl:if>
                    </div>     
                </div>
                <iaixsl:if test="count(/shop/commercial_banner3) &gt; 0">
                <iaixsl:if test="not(count(/shop/commercial_banner3/link) > position())">
                  <iaixsl:choose>
                    <iaixsl:when test="position() = 29"><iaixsl:for-each select="/shop/commercial_banner3/link[position() = 3]"><iaixsl:value-of disable-output-escaping="yes" select="html"/></iaixsl:for-each></iaixsl:when>
                    <iaixsl:otherwise></iaixsl:otherwise>
                  </iaixsl:choose>
                </iaixsl:if>
              </iaixsl:if>
            </iaixsl:for-each>
        </section>
    </iaixsl:if>

    <iaiajaxstart iai-ajax-id="dynamic_section" iai-ajax-generated="false"/>
        <iaixsl:variable name="param_search_ajax"></iaixsl:variable>
        <iaixsl:variable name="param_search_gfx_ajax"></iaixsl:variable>
        <iaixsl:variable name="versions_search_ajax">true</iaixsl:variable>
        <iaixsl:variable name="var_yousave_search_ajax"></iaixsl:variable>
        <iaixsl:variable name="priceTypeVat_ajax"><iaixsl:if test="(/shop/basket/@login and not(/shop/client_data/@uses_vat='false') or not(/shop/basket/@login)) and not(/shop/contact/owner/@vat_registered = 'false')"><![CDATA[true]]></iaixsl:if></iaixsl:variable>
        <iaixsl:variable name="priceTypeText_ajax"><iaixsl:if test="not($priceTypeVat_ajax = '')"><iaixsl:choose><iaixsl:when test="/shop/page/@price_type = 'net'"></iaixsl:when><iaixsl:when test="/shop/page/@price_type = 'gross'"></iaixsl:when></iaixsl:choose></iaixsl:if></iaixsl:variable>
        <iaixsl:variable name="var_net_prices_search_ajax"><iaixsl:if test="/shop/page/@price_type = 'net'"><iaixsl:value-of select="$priceTypeText_ajax"/></iaixsl:if></iaixsl:variable>
        <iaixsl:variable name="var_gross_prices_search_ajax"><iaixsl:if test="/shop/page/@price_type = 'gross'"><iaixsl:value-of select="$priceTypeText_ajax"/></iaixsl:if></iaixsl:variable>
        <iaixsl:variable name="var_b2b_search_ajax"></iaixsl:variable>
        <iaixsl:variable name="traitsDataID_ajax">2577</iaixsl:variable>
        <iaixsl:variable name="addcompare_txt_ajax"></iaixsl:variable>
        <iaixsl:for-each select="/shop/page/products/product">
            <iaixsl:if test="position() = 5 and (/shop/page/products/navigation/item[@type='current']/@counter = 1) and contains(/shop/page/products/additional/category_list/description, '#categoryDesc')">
                <iaixsl:value-of disable-output-escaping="yes" select="substring-after(/shop/page/products/additional/category_list/description, '#categoryDesc')"/>
            </iaixsl:if>
            <div class="product ">
                <iaixsl:attribute name="data-product_id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
                <iaixsl:attribute name="data-product_page"><iaixsl:value-of select="/shop/page/products/navigation/item[@type = 'current']/@counter - 1"/></iaixsl:attribute>
                <iaixsl:if test="position() = 1">
                    <iaixsl:attribute name="data-product_first"><![CDATA[true]]></iaixsl:attribute>
                </iaixsl:if>
                <iaixsl:if test="sizes/availability/@status = 'disable'">
                    <iaixsl:attribute name="data-product_disable"><![CDATA[true]]></iaixsl:attribute>
                </iaixsl:if>
                <!-- SALESmanago NextGen -->
                <iaixsl:if test="/shop/page/@ecommerce_module_class">
                    <iaixsl:attribute name="class">
                        product col-6 col-sm-4 py-3

                        <iaixsl:variable name="ecommerce_module_separator"><![CDATA[{productId}]]></iaixsl:variable>

                        <iaixsl:variable name="ecommerce_module_class_before"><iaixsl:value-of select="substring-before(/shop/page/@ecommerce_module_class, $ecommerce_module_separator)"/></iaixsl:variable>
                        <iaixsl:variable name="ecommerce_module_class_after"><iaixsl:value-of select="substring-after(/shop/page/@ecommerce_module_class, $ecommerce_module_separator)"/></iaixsl:variable>

                        <iaixsl:value-of select="$ecommerce_module_class_before"/><iaixsl:value-of select="@id"/><iaixsl:value-of select="$ecommerce_module_class_after"/>
                    </iaixsl:attribute>
                </iaixsl:if>

                <!-- YOUSAVE - aktywowane literałem label oszczędzasz XXX -->
                <iaixsl:if test="$var_yousave_search_ajax and not($var_yousave_search_ajax = '') and price/@yousave_formatted != ''">
                    <div class="product__yousave">
                        <span class="product__yousave --label"><iaixsl:value-of select="$var_yousave_search_ajax"/></span>
                        <span class="product__yousave --value"><iaixsl:value-of select="price/@yousave_formatted"/></span>
                    </div>
                </iaixsl:if>
                <a href="#add_favorite" class="product__favorite">
                    <iaixsl:attribute name="data-product-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
                    <i class="icon-star-outline"></i>
                </a>

                <!-- IKONA PRODUKTU -->
                <a class="product__icon d-flex justify-content-center align-items-center">
                    <iaixsl:attribute name="data-product-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
                    <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
                    <iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
                    <iaixsl:if test="traits/trait/@groupid = $traitsDataID_ajax">
                    <div class="product__counter">
                        <iaixsl:attribute name="counterDate">
                            <iaixsl:value-of select="traits/trait/@traitdescription"/>
                        </iaixsl:attribute>
                    </div>
                    </iaixsl:if>
                    <picture>
                        <source width="126" height="126">
                            <iaixsl:attribute name="media"><![CDATA[(max-width: 420px)]]></iaixsl:attribute>
                            <iaixsl:choose>
                                <iaixsl:when test="position() &gt; 4">
                                    <iaixsl:attribute name="data-srcset"><iaixsl:value-of disable-output-escaping="yes" select="icon_small"/></iaixsl:attribute>
                                </iaixsl:when>
                                <iaixsl:otherwise>
                                    <iaixsl:attribute name="srcset"><iaixsl:value-of disable-output-escaping="yes" select="icon_small"/></iaixsl:attribute>
                                </iaixsl:otherwise>
                            </iaixsl:choose>
                        </source>
                        <img src="/gfx/pol/loader.gif?r=1645454563" width="336" height="336">
                            <iaixsl:attribute name="alt"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
                            <iaixsl:choose>
                                <iaixsl:when test="position() &gt; 4">
                                    <iaixsl:attribute name="class"><![CDATA[b-lazy]]></iaixsl:attribute>
                                    <iaixsl:attribute name="data-src"><iaixsl:value-of disable-output-escaping="yes" select="icon"/></iaixsl:attribute>
                                </iaixsl:when>
                                <iaixsl:otherwise>
                                    <iaixsl:attribute name="src"><iaixsl:value-of disable-output-escaping="yes" select="icon"/></iaixsl:attribute>
                                </iaixsl:otherwise>
                            </iaixsl:choose>
                        </img>
                    </picture>

                    <!-- LABEL -->
                    <iaixsl:variable name="productUnavailable"><iai:variable vid="Chwilowo niedostępny"/></iaixsl:variable>
                    <iaixsl:choose>
                        <iaixsl:when test="not($productUnavailable = '') and sizes/availability/@status = 'disable'">
                            <strong class="label_icons">
                                <span class="label --disable">
                                    <iaixsl:value-of select="$productUnavailable"/>
                                </span>
                            </strong>
                        </iaixsl:when>
                        <iaixsl:when test="@promo or @new or @bestseller or @discount or (@distinguished and not(@bestseller and @discount)) or (traits/trait[@groupid = '11193'])">
                            <strong class="label_icons">
                                <iaixsl:if test="traits/trait[@groupid = '11193']">
                                    <iaixsl:for-each select="traits/trait[@groupid = '11193']">
                                        <span class="label --trait">
                                            <iaixsl:value-of select="@traitlongdescription"/>
                                        </span>                                    
                                    </iaixsl:for-each>
                                </iaixsl:if>                                        
                                <iaixsl:if test="@promo">
                                    <span class="label --promo">
                                        <iai:variable vid="W promocji"/>
                                    </span>
                                </iaixsl:if>
                                <iaixsl:if test="@new">
                                    <span class="label --new">
                                        <iai:variable vid="Nowość"/>
                                    </span>
                                </iaixsl:if>
                                <iaixsl:choose>
                                    <iaixsl:when test="@promo and @new">
                                    </iaixsl:when>
                                    <iaixsl:when test="@promo or @new">
                                        <iaixsl:choose>
                                            <iaixsl:when test="@bestseller">
                                                <span class="label --bestseller">
                                                    <iai:variable vid="Nasz bestseller"/>
                                                </span>
                                            </iaixsl:when>
                                            <iaixsl:when test="@discount">
                                                <span class="label --discount">
                                                    <iai:variable vid="Przecena"/>
                                                </span>
                                            </iaixsl:when>
                                            <iaixsl:when test="@distinguished">
                                                <span class="label --distinguished">
                                                    <iai:variable vid="Polecany"/>
                                                </span>
                                            </iaixsl:when>
                                        </iaixsl:choose>
                                    </iaixsl:when>
                                    <iaixsl:otherwise>
                                        <iaixsl:if test="@bestseller">
                                            <span class="label --bestseller">
                                                <iai:variable vid="Nasz bestseller"/>
                                            </span>
                                        </iaixsl:if>
                                        <iaixsl:if test="@discount">
                                            <span class="label --discount">
                                                <iai:variable vid="Przecena"/>
                                            </span>
                                        </iaixsl:if>
                                        <iaixsl:if test="@distinguished and not(@bestseller and @discount)">
                                            <span class="label --distinguished">
                                                <iai:variable vid="Polecany"/>
                                            </span>
                                        </iaixsl:if>
                                    </iaixsl:otherwise>
                                </iaixsl:choose>
                            </strong>
                        </iaixsl:when>
                    </iaixsl:choose>
                </a>
            
                <div class="product__details">
                    <!-- PRODUCENT -->
                    <iaixsl:if test="(firm/@name) and (firm/@id != '0')">
                    <div class="producer">
                        <a class="brand">
                            <iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="firm/@name"/></iaixsl:attribute>
                            <iaixsl:attribute name="href"><iaixsl:value-of disable-output-escaping="yes" select="firm/@productslink"/></iaixsl:attribute>
                            <iaixsl:value-of disable-output-escaping="yes" select="firm/@name"/>
                        </a>
                    </div>
                    </iaixsl:if>
                    <!-- NAZWA PRODUKTU -->
                    <h3>
                        <a class="product__name">
                            <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
                            <iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
                            <iaixsl:value-of disable-output-escaping="yes" select="name"/>
                        </a>
                    </h3>

                    <!-- CENA -->
                    <iaixsl:choose>
                        <!-- Cena netto -->
                        <iaixsl:when test="$var_net_prices_search_ajax and not($var_net_prices_search_ajax = '')">
                            <div class="product__prices">
                                <iaixsl:choose>
                                    <iaixsl:when test="(sizes/prices/@minprice_net_formatted != sizes/prices/@maxprice_net_formatted) or (sizes/prices/@minprice_unit_formatted != sizes/prices/@maxprice_unit_formatted)">
                                        <iaixsl:choose>
                                            <iaixsl:when test="(sizes/prices/@size_min_maxprice_net_formatted != sizes/prices/@size_max_maxprice_net_formatted) or (sizes/prices/@size_min_maxprice_unit_formatted != sizes/prices/@size_max_maxprice_unit_formatted)">
                                                <del class="price --max">
                                                    <iaixsl:choose>
                                                        <iaixsl:when test="sizes/prices/@size_min_maxprice_unit_formatted">
                                                            <span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_unit_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_unit_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search_ajax"/></span>
                                                        </iaixsl:when>
                                                        <iaixsl:otherwise>
                                                            <span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_net_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_net_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search_ajax"/></span>
                                                        </iaixsl:otherwise>
                                                    </iaixsl:choose>
                                                </del>
                                            </iaixsl:when>

                                            <iaixsl:when test="sizes/size/price/@srp_net != '' and sizes/size/price/@srp != sizes/size/price/@value">
                                                <del class="price --max">
                                                    <iaixsl:value-of select="sizes/size/price/@srp_net_formatted"/>
                                                </del>
                                            </iaixsl:when>
                                        </iaixsl:choose>
                                        <strong class="price">
                                            
                                            <iaixsl:choose>
                                                <iaixsl:when test="sizes/prices/@minprice_unit_formatted">
                                                    <iaixsl:value-of select="sizes/prices/@minprice_unit_formatted"/>
                                                </iaixsl:when>
                                                <iaixsl:otherwise>
                                                    <iaixsl:value-of select="sizes/prices/@minprice_net_formatted"/>
                                                </iaixsl:otherwise>
                                            </iaixsl:choose>
                                                - 
                                            <iaixsl:choose>
                                                <iaixsl:when test="sizes/prices/@maxprice_unit_formatted">
                                                    <iaixsl:value-of select="sizes/prices/@maxprice_unit_formatted"/>
                                                </iaixsl:when>
                                                <iaixsl:otherwise>
                                                    <iaixsl:value-of select="sizes/prices/@maxprice_net_formatted"/>
                                                </iaixsl:otherwise>
                                            </iaixsl:choose>

                                            <!-- <iaixsl:if test="sizes/prices/@minprice_unit_formatted">
                                                <iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby" /><iaixsl:text><![CDATA[ ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" />
                                            </iaixsl:if> -->
                                            <span class="price_vat"><iaixsl:value-of select="$var_net_prices_search_ajax"/></span>
                                        </strong>
                                    </iaixsl:when>
                                    <iaixsl:when test="price/@price_net = 0 and not(/shop/basket/@wholesaler = 'true') and $var_b2b_search and not($var_b2b_search_ajax = '')">
                                        <a class="price --hurt">
                                            <iaixsl:attribute name="title"><iaixsl:value-of select="$var_b2b_search_ajax"/></iaixsl:attribute>
                                            <iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/signin/@url"/></iaixsl:attribute>
                                            <iaixsl:value-of select="$var_b2b_search_ajax"/>
                                        </a>
                                    </iaixsl:when>

                                    <iaixsl:when test="(sizes/prices/@minprice_net = 0) and not(price/@points)">
                                        <a class="price --phone">
                                            <iaixsl:attribute name="title"><iai:variable vid="Kliknij, by przejść do formularza kontaktu"/></iaixsl:attribute>
                                            <iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/contact/@url"/></iaixsl:attribute>
                                            <iai:variable vid="Cena na telefon"/>
                                        </a>
                                    </iaixsl:when>
                                    <iaixsl:otherwise>
                                        <iaixsl:choose>
                                            <iaixsl:when test="price/@maxprice_net or price/@maxprice_unit">
                                                <del class="price --max">
                                                    
                                                    <iaixsl:choose>
                                                        <iaixsl:when test="price/@maxprice_unit_formatted">
                                                            <iaixsl:value-of select="price/@maxprice_unit_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search_ajax"/></span>
                                                        </iaixsl:when>
                                                        <iaixsl:otherwise>
                                                            <iaixsl:value-of select="price/@maxprice_net_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search_ajax"/></span>
                                                        </iaixsl:otherwise>
                                                    </iaixsl:choose>
                                                </del>
                                            </iaixsl:when>
                                            <iaixsl:when test="sizes/size/price/@srp_net != '' and sizes/size/price/@srp != sizes/size/price/@value">
                                                <del class="price --max">
                                                    <iaixsl:value-of select="sizes/size/price/@srp_net_formatted"/>
                                                </del>
                                            </iaixsl:when>
                                        </iaixsl:choose>
                                        <strong class="price">
                                            <iaixsl:choose>
                                                <iaixsl:when test="price/@price_unit_net_formatted">
                                                    <iaixsl:value-of select="price/@price_unit_net_formatted"/>
                                                    <!-- <iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby" /><iaixsl:text><![CDATA[ ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" /> -->
                                                </iaixsl:when>
                                                <iaixsl:otherwise>
                                                    <iaixsl:value-of select="price/@price_net_formatted"/>
                                                </iaixsl:otherwise>
                                            </iaixsl:choose>
                                            <span class="price_vat"><iaixsl:value-of select="$var_net_prices_search_ajax"/></span>
                                        </strong>

                                        <!-- <iaixsl:if test="price/@points">
                                    <iai:variable vid="TXT_111232_comma" description="przecinek między cenami"><![CDATA[]]></iai:variable><span class="price points"><iaixsl:value-of select="price/@points"/><span class="currency"><iai:variable vid="TXT_111232_points" description="PKT"><![CDATA[pkt]]></iai:variable></span></span>
                                        </iaixsl:if> -->

                                    </iaixsl:otherwise>
                                </iaixsl:choose>

                                <!-- CENA ZA KILO -->
                                <iaixsl:if test="price/@unit_converted_price_net_formatted"><small class="price --convert"><iaixsl:value-of select="price/@unit_converted_price_net_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search_ajax"/></span></small>
                                </iaixsl:if>

                                <!-- LABEL -->
                                <iaixsl:if test="sizes/size/price/@srp_diff_percent">
                                    <div class="diff__percent">
                                        <span>- <iaixsl:value-of select="sizes/size/price/@srp_diff_percent"/> %</span>
                                    </div>
                                </iaixsl:if>
                            </div>
                        </iaixsl:when>
                        <!-- Cena detaliczna -->
                        <iaixsl:otherwise>
                            <div class="product__prices">
                                <iaixsl:choose>
                                    <iaixsl:when test="(sizes/prices/@minprice_formatted != sizes/prices/@maxprice_formatted) or (sizes/prices/@minprice_unit_formatted != sizes/prices/@maxprice_unit_formatted)">
                                        <iaixsl:choose>
                                            <iaixsl:when test="(sizes/prices/@size_min_maxprice_formatted != sizes/prices/@size_max_maxprice_formatted) or (sizes/prices/@size_min_maxprice_unit_formatted != sizes/prices/@size_max_maxprice_unit_formatted)">
                                                <del class="price --max">
                                                    <iaixsl:choose>
                                                        <iaixsl:when test="sizes/prices/@size_min_maxprice_unit_formatted">
                                                            <span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_unit_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_unit_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search_ajax"/></span>
                                                        </iaixsl:when>
                                                        <iaixsl:otherwise>
                                                            <span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search_ajax"/></span>
                                                        </iaixsl:otherwise>
                                                    </iaixsl:choose>
                                                </del>
                                            </iaixsl:when>

                                            <iaixsl:when test="sizes/size/price/@srp_net != '' and sizes/size/price/@srp != sizes/size/price/@value">
                                                <del class="price --max">
                                                    <iaixsl:value-of select="sizes/size/price/@srp_formatted"/>
                                                </del>
                                            </iaixsl:when>
                                        </iaixsl:choose>
                                        <strong class="price">
                                            
                                            <iaixsl:choose>
                                                <iaixsl:when test="sizes/prices/@minprice_unit_formatted">
                                                    <iaixsl:value-of select="sizes/prices/@minprice_unit_formatted"/>
                                                </iaixsl:when>
                                                <iaixsl:otherwise>
                                                    <iaixsl:value-of select="sizes/prices/@minprice_formatted"/>
                                                </iaixsl:otherwise>
                                            </iaixsl:choose>
                                                - 
                                            <iaixsl:choose>
                                                <iaixsl:when test="sizes/prices/@maxprice_unit_formatted">
                                                    <iaixsl:value-of select="sizes/prices/@maxprice_unit_formatted"/>
                                                </iaixsl:when>
                                                <iaixsl:otherwise>
                                                    <iaixsl:value-of select="sizes/prices/@maxprice_formatted"/>
                                                </iaixsl:otherwise>
                                            </iaixsl:choose>

                                            <!-- <iaixsl:if test="sizes/prices/@minprice_unit_formatted">
                                                <iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby" /><iaixsl:text><![CDATA[ ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" />
                                            </iaixsl:if> -->
                                            <span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search_ajax"/></span>
                                        </strong>
                                    </iaixsl:when>

                                    <iaixsl:when test="(sizes/prices/@minprice = 0) and not(price/@points)">
                                        <a class="price --phone">
                                            <iaixsl:attribute name="title"><iai:variable vid="Kliknij, by przejść do formularza kontaktu"/></iaixsl:attribute>
                                            <iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/contact/@url"/></iaixsl:attribute>
                                            <iai:variable vid="Cena na telefon"/>
                                        </a>
                                    </iaixsl:when>
                                    <iaixsl:otherwise>
                                        <iaixsl:choose>
                                            <iaixsl:when test="price/@maxprice or price/@maxprice_unit">
                                                <del class="price --max">
                                                    
                                                    <iaixsl:choose>
                                                        <iaixsl:when test="price/@maxprice_unit_formatted">
                                                            <iaixsl:value-of select="price/@maxprice_unit_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search_ajax"/></span>
                                                        </iaixsl:when>
                                                        <iaixsl:otherwise>
                                                            <iaixsl:value-of select="price/@maxprice_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search_ajax"/></span>
                                                        </iaixsl:otherwise>
                                                    </iaixsl:choose>
                                                </del>
                                            </iaixsl:when>

                                            <iaixsl:when test="sizes/size/price/@srp_net != '' and sizes/size/price/@srp != sizes/size/price/@value">
                                                <del class="price --max">
                                                    <iaixsl:value-of select="sizes/size/price/@srp_formatted"/>
                                                </del>
                                            </iaixsl:when>
                                        </iaixsl:choose>
                                        <strong class="price">
                                            <iaixsl:choose>
                                                <iaixsl:when test="price/@price_unit_formatted">
                                                    <iaixsl:value-of select="price/@price_unit_formatted"/>
                                                    <!-- <iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby" /><iaixsl:text><![CDATA[ ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" /> -->
                                                </iaixsl:when>
                                                <iaixsl:otherwise>
                                                    <iaixsl:value-of select="sizes/prices/@minprice_formatted"/>
                                                    <!-- <span class="price__unit"><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit" /></span> -->
                                                </iaixsl:otherwise>
                                            </iaixsl:choose>
                                            <span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search_ajax"/></span>
                                        </strong>

                                        <!-- <iaixsl:if test="price/@yousave_percent">
                                                <span class="promo__percent">-<iaixsl:value-of select="price/@yousave_percent"/>%</span>
                                        </iaixsl:if> -->

                                        <!-- <iaixsl:if test="price/@points">
                                            <iai:variable vid="TXT_111232_comma" description="przecinek między cenami"><![CDATA[]]></iai:variable><span class="price points"><iaixsl:value-of select="price/@points"/><span class="currency"><iai:variable vid="TXT_111232_points" description="PKT"><![CDATA[pkt]]></iai:variable></span></span>
                                        </iaixsl:if> -->

                                    </iaixsl:otherwise>
                                </iaixsl:choose>

                                <!-- CENA ZA KILO -->
                                <iaixsl:if test="price/@unit_converted_price_formatted"><small class="price --convert"><iaixsl:value-of select="price/@unit_converted_price_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search_ajax"/></span></small>
                                </iaixsl:if>

                                <!-- LABEL -->
                                <iaixsl:if test="sizes/size/price/@srp_diff_percent">
                                    <div class="diff__percent">
                                        <span>- <iaixsl:value-of select="sizes/size/price/@srp_diff_percent"/> %</span>
                                    </div>
                                </iaixsl:if>
                            </div>
                        </iaixsl:otherwise>
                    </iaixsl:choose>

                    <!-- DO PORÓWNANIA -->
                    <div class="product__compare">
                        <iaixsl:if test="/shop/compare/@active = 'y' and $addcompare_txt_ajax">
                            <iaixsl:attribute name="class"><![CDATA[product__compare --has-child]]></iaixsl:attribute>

                            <iaixsl:choose>
                                <iaixsl:when test="@id = /shop/compare/product/@id">
                                    <a class="product__compare_item --remove btn" rel="nofollow">
                                        <iaixsl:attribute name="href"><iaixsl:choose><iaixsl:when test="/shop/action/settings/@url"><iaixsl:value-of select="/shop/action/settings/@url"/></iaixsl:when><iaixsl:otherwise><![CDATA[settings.php]]></iaixsl:otherwise></iaixsl:choose><![CDATA[?comparers=remove&amp;product=]]><iaixsl:value-of select="@id"/></iaixsl:attribute>
                                        <iaixsl:attribute name="title"><iai:variable vid="Kliknij, aby usunąć produkt z porównywarki"/></iaixsl:attribute>
                                        - <iai:variable vid="Usuń z porównania"/>
                                    </a>
                                </iaixsl:when>
                                <iaixsl:otherwise>
                                    <a class="product__compare_item --add btn" rel="nofollow">
                                        <iaixsl:attribute name="href"><iaixsl:choose><iaixsl:when test="/shop/action/settings/@url"><iaixsl:value-of select="/shop/action/settings/@url"/></iaixsl:when><iaixsl:otherwise><![CDATA[settings.php]]></iaixsl:otherwise></iaixsl:choose><![CDATA[?comparers=add&amp;product=]]><iaixsl:value-of select="@id"/></iaixsl:attribute>
                                        <iaixsl:attribute name="title"><iai:variable vid="Kliknij, aby dodać produkt do porównania"/></iaixsl:attribute>
                                        <iaixsl:value-of select="$addcompare_txt_ajax"/>
                                    </a>
                                </iaixsl:otherwise>
                            </iaixsl:choose>
                        </iaixsl:if>
                    </div>

                    <div class="product__sizes">
                        <iaixsl:if test="sizes/size/@type = 'onesize' or sizes/size/@type = 'uniw'">
                            <iaixsl:attribute name="style"><![CDATA[display:none;]]></iaixsl:attribute>
                        </iaixsl:if>
                        <div class="product__sizes__sub">
                            <iaixsl:for-each select="sizes/size">
                                <iaixsl:choose>
                                    <iaixsl:when test="(@amount &gt; 0) or (@amount = '-1')">
                                        <a class="product__sizes__button">
                                            <iaixsl:attribute name="data-type"><iaixsl:value-of disable-output-escaping="yes" select="@type"/></iaixsl:attribute>
                                            <iaixsl:value-of disable-output-escaping="yes" select="@description"/>
                                        </a>
                                    </iaixsl:when>
                                    <iaixsl:otherwise>
                                    <a class="product__sizes__button --disabled">
                                        <iaixsl:attribute name="data-type"><iaixsl:value-of disable-output-escaping="yes" select="@type"/></iaixsl:attribute>
                                        <iaixsl:value-of disable-output-escaping="yes" select="@description"/>
                                    </a>
                                    </iaixsl:otherwise>
                                </iaixsl:choose>
                            </iaixsl:for-each>
                        </div>
                    </div>

                    <!-- WARIANTY I ROZMIARY -->
                    <iaixsl:if test="not($versions_search_ajax)">
                        <iaixsl:if test="(count(versions/version[@gfx_small]) &gt; 1 and count(versions/version) = count(versions/version[@gfx_small])) or (sizes/size/@type and not(sizes/size/@type='uniw'))">
                                <div class="product__details py-1 px-3">
                                        <iaixsl:if test="sizes/size/@type and not(sizes/size/@type='uniw')">
                                                <div class="product__sizes mb-1">
                                                        <label class="product__size --label"><iai:variable vid="Rozmiar"/>:</label>
                                                        <iaixsl:for-each select="sizes/size">
                                                                <span class="product__size"><iaixsl:value-of select="@description"/></span>
                                                        </iaixsl:for-each>
                                                </div>
                                        </iaixsl:if>

                                        <iaixsl:if test="count(versions/version/@gfx_small) &gt; 1">
                                                <div class="product__versions mx-n1">
                                                        <iaixsl:for-each select="versions/version">
                                                                <a class="product__version">
                                                                        <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
                                                                        <img>
                                                                                <iaixsl:attribute name="src"><iaixsl:value-of select="@gfx_small"/></iaixsl:attribute>
                                                                                <iaixsl:attribute name="alt"><iaixsl:value-of select="@name"/></iaixsl:attribute>
                                                                        </img>
                                                                </a>
                                                        </iaixsl:for-each>
                                                </div>
                                        </iaixsl:if>
                                </div>
                        </iaixsl:if>
                    </iaixsl:if>

                    <!-- PARAMETRY -->
                    <iaixsl:if test="not($param_search_ajax)">
                        <iaixsl:if test="traits/trait[not(@gfx)] and traits/trait[not(contains(@groupdescription, 'gs1:'))]">
                            <div class="product__traits d-none mt-2">
                                <ul>
                                    <iaixsl:for-each select="traits/trait[not(@gfx)]">
                                        <iaixsl:if test="not(@groupid = preceding-sibling::trait/@groupid) and not(contains(@groupdescription, 'gs1:'))">
                                            <li class="trait">
                                                <span class="trait__name"><iaixsl:value-of select="@groupdescription"/>: </span>
                                                <div class="trait__values">
                                                    <a class="trait__value"><iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute><iaixsl:value-of select="@traitdescription"/></a>
                                                    <iaixsl:if test="@groupid = following-sibling::trait/@groupid">
                                                        <iaixsl:variable name="temporaryGroup"><iaixsl:value-of select="@groupid"/></iaixsl:variable><iaixsl:for-each select="following-sibling::trait[(@groupid = $temporaryGroup)]">, <a class="trait__value"><iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute><iaixsl:value-of select="@traitdescription"/></a></iaixsl:for-each>
                                                    </iaixsl:if>
                                                </div>
                                            </li>
                                        </iaixsl:if>
                                    </iaixsl:for-each>
                                </ul>
                            </div>
                        </iaixsl:if>
                    </iaixsl:if>

                    <!-- PARAMETRY GRAFICZNY -->
                    <iaixsl:if test="not($param_search_gfx_ajax)">
                        <iaixsl:if test="traits/trait[@gfx2]">
                            <div class="product__traits --gfx my-2 mb-md-0">
                                <ul>
                                    <iaixsl:for-each select="traits/trait[@gfx2]">
                                        <li class="trait">
                                            <a class="trait__gfx">
                                                <iaixsl:attribute name="title"><iaixsl:value-of select="@groupdescription"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="@traitdescription"/></iaixsl:attribute>
                                                <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
                                                <img class="trait__img">
                                                    <iaixsl:attribute name="src"><iaixsl:value-of select="@gfx2"/></iaixsl:attribute>
                                                    <iaixsl:attribute name="alt"><iaixsl:value-of select="@traitdescription"/></iaixsl:attribute>
                                                </img>
                                            </a>
                                        </li>
                                    </iaixsl:for-each>
                                </ul>
                            </div>
                        </iaixsl:if>
                    </iaixsl:if>
                </div>     
            </div>
        </iaixsl:for-each>
    <iaiajaxend/>
    <iaixsl:if test="/shop/page/search_params/*"> </iaixsl:if>
<cdata-end/></iai:componentsdata></iai:component>

<?xml version="1.0" encoding="UTF-8"?><iai:component><iai:componentsdata><cdata-start/>
	<!-- SETTINGS -->
	<iaixsl:variable name="param_search"></iaixsl:variable>
	<iaixsl:variable name="param_search_gfx">true</iaixsl:variable>
	<iaixsl:variable name="versions_search">true</iaixsl:variable>
	<iaixsl:variable name="var_yousave_search"></iaixsl:variable>
	<iaixsl:variable name="var_net_prices_search"><iaixsl:if test="/shop/page/@price_type = 'net'"><iaixsl:value-of select="$priceTypeText"/></iaixsl:if></iaixsl:variable>
	<iaixsl:variable name="var_gross_prices_search"><iaixsl:if test="/shop/page/@price_type = 'gross'"><iaixsl:value-of select="$priceTypeText"/></iaixsl:if></iaixsl:variable>
	<iaixsl:variable name="var_b2b_search"></iaixsl:variable>
	<!-- TEXTS -->
	<iaixsl:variable name="addcompare_txt"></iaixsl:variable>

	<iaixsl:if test="/shop/page/products/display_mode/@active = 'normal'">
		<section id="search" class="search products mb-4 mb-md-8">

    	<!-- OMNIBUS -->
			<!-- Zmienna przechowująca stan Omnibusa - włączony (omnibus = 1) / wyłączony -->
    	<iaixsl:variable name="var_omnibus_enabled"><iaixsl:if test="/shop/@omnibus = 1"><![CDATA[true]]></iaixsl:if></iaixsl:variable>
    	<!-- OMNIBUS-END -->

			<iaixsl:for-each select="/shop/page/products/product">
				<div class="product col-6 col-sm-4">
					<iaixsl:attribute name="data-product_id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
					<iaixsl:attribute name="data-product_page"><iaixsl:value-of select="/shop/page/products/navigation/item[@type = 'current']/@counter - 1"/></iaixsl:attribute>
					<iaixsl:if test="position() = 1">
						<iaixsl:attribute name="data-product_first"><![CDATA[true]]></iaixsl:attribute>
					</iaixsl:if>
					<iaixsl:if test="sizes/availability/@status = 'disable'">
						<iaixsl:attribute name="data-product_disable"><![CDATA[true]]></iaixsl:attribute>
					</iaixsl:if>
					<!--<iaixsl:if test="traits/trait/@groupid = '31'">-->
					<!--  <iaixsl:attribute name="data-silhouette"><iaixsl:value-of select="traits/trait[@groupid = '31']/@traitdescription"/></iaixsl:attribute>-->
					<!--</iaixsl:if>-->
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
					
					<!-- DODAWANIE DO LISTY -->
					<a href="#add_favorite" class="product__favorite">
						<iaixsl:attribute name="data-product-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
						<iaixsl:attribute name="title"><iai:variable vid="Dodaj do listy zakupowej"/></iaixsl:attribute>
						<i class="icon-heart"></i>
					</a>

					<!-- IKONA PRODUKTU -->
					<div class="product__icon__container">
			      <iaixsl:attribute name="data-product-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
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
							<iaixsl:when test="@promo or @new or @bestseller or @discount or (@distinguished and not(@bestseller and @discount))">
								<strong class="label_icons">
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
						
			      <iaixsl:choose>
  					  <iaixsl:when test="enclosures/images/enclosure/@medium">
  					    <ul class="product__icon__list">
  					      <iaixsl:for-each select="enclosures/images/enclosure">
  					        <li class="product__icon__list__item">
  					          <iaixsl:attribute name="data-position"><iaixsl:value-of select="@position"/></iaixsl:attribute>
  					          
  					          <a class="product__icon d-flex justify-content-center align-items-center">
    			              <iaixsl:attribute name="data-product-id"><iaixsl:value-of select="../../../@id"/></iaixsl:attribute>
            						<iaixsl:attribute name="href"><iaixsl:value-of select="../../../@link"/></iaixsl:attribute>
            						<iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="../../../name"/></iaixsl:attribute>
            						<picture>
            							<source>
            								<iaixsl:attribute name="media"><![CDATA[(max-width: 420px)]]></iaixsl:attribute>
            								<iaixsl:choose>
            									<iaixsl:when test="position() &gt; 1">
            										<iaixsl:attribute name="data-srcset"><iaixsl:value-of disable-output-escaping="yes" select="@icon"/></iaixsl:attribute>
            									</iaixsl:when>
            									<iaixsl:otherwise>
            										<iaixsl:attribute name="srcset"><iaixsl:value-of disable-output-escaping="yes" select="@icon"/></iaixsl:attribute>
            									</iaixsl:otherwise>
            								</iaixsl:choose>
            							</source>
            							<img src="/gfx/pol/loader.gif?r=1643713476">
            								<iaixsl:attribute name="alt"><iaixsl:value-of disable-output-escaping="yes" select="../../../name"/></iaixsl:attribute>
            								<iaixsl:choose>
            									<iaixsl:when test="position() &gt; 1">
            										<iaixsl:attribute name="class"><![CDATA[b-lazy]]></iaixsl:attribute>
            										<iaixsl:attribute name="data-src"><iaixsl:value-of disable-output-escaping="yes" select="@medium"/></iaixsl:attribute>
            									</iaixsl:when>
            									<iaixsl:otherwise>
            										<iaixsl:attribute name="src"><iaixsl:value-of disable-output-escaping="yes" select="@medium"/></iaixsl:attribute>
            									</iaixsl:otherwise>
            								</iaixsl:choose>
            							</img>
            						</picture>
    			            </a>
  					        </li>
			            </iaixsl:for-each>
			          </ul>
  					  </iaixsl:when>
  					  <iaixsl:otherwise>
  					    <a class="product__icon d-flex justify-content-center align-items-center">
      						<iaixsl:attribute name="data-product-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
      						<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
      						<iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
      				    <iaixsl:choose>
                    <iaixsl:when test="icon_small_second and not(icon_small_second = '' or icon_small_second = '/')">
                      <picture>
                        <source media="(min-width: 421px)" type="image/webp">
                          <iaixsl:attribute name="srcset"><iaixsl:value-of select="icon"/></iaixsl:attribute>
                        </source>
                        <source media="(min-width: 421px)" type="image/jpeg">
                          <iaixsl:attribute name="srcset"><iaixsl:value-of select="icon_src_second"/></iaixsl:attribute>
                        </source>
                        <source type="image/webp">
                          <iaixsl:attribute name="srcset"><iaixsl:value-of select="icon_small_second"/></iaixsl:attribute>
                        </source>
                        <img src="/gfx/pol/loader.gif?r=1643713476">
                          <iaixsl:attribute name="alt"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
                          <iaixsl:choose>
                            <iaixsl:when test="position() &gt; 1">
                              <iaixsl:attribute name="class"><![CDATA[b-lazy]]></iaixsl:attribute>
                              <iaixsl:attribute name="data-src"><iaixsl:value-of disable-output-escaping="yes" select="icon_small_second"/></iaixsl:attribute>
                            </iaixsl:when>
                            <iaixsl:otherwise>
                              <iaixsl:attribute name="src"><iaixsl:value-of disable-output-escaping="yes" select="icon_small_second"/></iaixsl:attribute>
                            </iaixsl:otherwise>
                          </iaixsl:choose>
                        </img>
                      </picture>                    
                    </iaixsl:when>
                    <iaixsl:otherwise>
                      <picture>
          							<source>
          								<iaixsl:attribute name="media"><![CDATA[(max-width: 420px)]]></iaixsl:attribute>
          								<iaixsl:choose>
          									<iaixsl:when test="position() &gt; 1">
          										<iaixsl:attribute name="data-srcset"><iaixsl:value-of disable-output-escaping="yes" select="icon_small"/></iaixsl:attribute>
          									</iaixsl:when>
          									<iaixsl:otherwise>
          										<iaixsl:attribute name="srcset"><iaixsl:value-of disable-output-escaping="yes" select="icon_small"/></iaixsl:attribute>
          									</iaixsl:otherwise>
          								</iaixsl:choose>
          							</source>
          							<img src="/gfx/pol/loader.gif?r=1643713476">
          								<iaixsl:attribute name="alt"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
          								<iaixsl:choose>
          									<iaixsl:when test="position() &gt; 1">
          										<iaixsl:attribute name="class"><![CDATA[b-lazy]]></iaixsl:attribute>
          										<iaixsl:attribute name="data-src"><iaixsl:value-of disable-output-escaping="yes" select="icon"/></iaixsl:attribute>
          									</iaixsl:when>
          									<iaixsl:otherwise>
          										<iaixsl:attribute name="src"><iaixsl:value-of disable-output-escaping="yes" select="icon"/></iaixsl:attribute>
          									</iaixsl:otherwise>
          								</iaixsl:choose>
          							</img>
          						</picture>
                    </iaixsl:otherwise>
                  </iaixsl:choose>
      					</a>
  					  </iaixsl:otherwise>
  					</iaixsl:choose>
			    </div>
			    
			    <div class="product__info__container">
			      <div class="product__info__row">
			        <div class="product__info__col --name">
			          <!-- NAZWA PRODUKTU -->
      					<h3>
      						<a class="product__name">
      							<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
      							<iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
      							<iaixsl:value-of disable-output-escaping="yes" select="name"/>
      						</a>
      					</h3>
      					<!-- PARAMETRY -->
      					<iaixsl:if test="not($param_search)">
      						<iaixsl:if test="traits/trait[@groupid = '21']">
      							<div class="product__traits">
      								<ul>
      									<iaixsl:for-each select="traits/trait">
      										<iaixsl:if test="@groupid = '21'">
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
			        </div>
  			      <div class="product__info__col --price">
  			        <!-- CENA -->
      					<iaixsl:choose>
      						<!-- Cena netto -->
      						<iaixsl:when test="$var_net_prices_search and not($var_net_prices_search = '')">
      							<!-- OMNIBUS -->
      							<!-- Najniższa cena Omnibusa z listy rozmiarów -->
      							<iaixsl:variable name="var_omnibus_min" ><iaixsl:for-each select="sizes/size[price/@omnibus_price_net]">
      								<iaixsl:sort select="price/@omnibus_price_net" data-type="number"/>
      								<iaixsl:if test="position() = 1"><xsl:value-of select="price/@omnibus_price_net_formatted"/></iaixsl:if>
      							</iaixsl:for-each></iaixsl:variable>
      
      							<!-- Najwyższa cena Omnibusa z listy rozmiarów -->
      							<iaixsl:variable name="var_omnibus_max" ><iaixsl:for-each select="sizes/size[price/@omnibus_price_net]">
      								<iaixsl:sort select="price/@omnibus_price_net" data-type="number" order="descending"/>
      								<iaixsl:if test="position() = 1"><xsl:value-of select="price/@omnibus_price_net_formatted"/></iaixsl:if>
      							</iaixsl:for-each></iaixsl:variable>
      
      							<!-- Cena lub przedział Omnibusa w zależności od tego czy najniższa i najwyższa cena Omnibusa są od siebie różne -->
      							<iaixsl:variable name="var_omnibus"><iaixsl:if test="$var_omnibus_enabled = 'true'"><iaixsl:choose>
      								<iaixsl:when test="$var_omnibus_min != $var_omnibus_max">
      									<span><iaixsl:value-of select="$var_omnibus_min"/></span><b><iaixsl:text><![CDATA[ - ]]></iaixsl:text></b><span><iaixsl:value-of select="$var_omnibus_max"/></span>
      								</iaixsl:when>
      								<iaixsl:when test="$var_omnibus_min != ''">
      									<iaixsl:value-of select="$var_omnibus_min" />
      								</iaixsl:when>
      								<iaixsl:when test="@product_type = 'virtual' and (count(sizes/size[price/@omnibus_price_net]) = 0) and price/@omnibus_price_net_formatted">
      									<iaixsl:value-of select="price/@omnibus_price_net_formatted" />
      								</iaixsl:when>
      							</iaixsl:choose></iaixsl:if></iaixsl:variable>
      
      							<!-- Zmienna przechowująca informację czy ma być wyświetlona skrócona wersja Omnibusa -->
      							<iaixsl:variable name="var_omnibus_short"><iaixsl:if test="$var_omnibus_enabled = 'true'"><iaixsl:choose>
      								<iaixsl:when test="sizes/prices/@size_min_maxprice_net_formatted != sizes/prices/@size_max_maxprice_net_formatted and sizes/prices/@size_min_maxprice_net_formatted = $var_omnibus_min and sizes/prices/@size_max_maxprice_net_formatted = $var_omnibus_max"><![CDATA[true]]></iaixsl:when>
      								<iaixsl:when test="price/@maxprice_net_formatted = $var_omnibus"><![CDATA[true]]></iaixsl:when>
      							</iaixsl:choose></iaixsl:if></iaixsl:variable>
      
      							<!-- OMNIBUS-FALLBACK -->
      							<!-- Zmienna przechowująca tablicę dat wszystkich rozmiarów w formacie [data; typ rozmiaru #separator# data; typ rozmiaru] -->
      							<!-- Jeśli ilość rozmiarów jest mniejsza niż 1 lub rozmiary nie zawierają atrybutu z datą ostatniej zmiany ceny to zostanie użyta data z węzła /product/price -->
      							<iaixsl:variable name="last_price_change_date"><iaixsl:choose>
      								<iaixsl:when test="sizes/size/price and (count(sizes/size) &gt; 1)"><iaixsl:for-each select="sizes/size[price/@last_price_change_date]"><iaixsl:if test="@type and price/@last_price_change_date"><iaixsl:value-of select="price/@last_price_change_date"/><![CDATA[;']]><iaixsl:value-of select="@type"/><![CDATA[']]><iaixsl:if test="not(position() = last())"><![CDATA[#separator#]]></iaixsl:if></iaixsl:if></iaixsl:for-each></iaixsl:when>
      								<iaixsl:when test="price/@last_price_change_date"><iaixsl:value-of select="price/@last_price_change_date"/></iaixsl:when>
      							</iaixsl:choose></iaixsl:variable>
      
      							<!-- Zmienna przechowująca informację czy fallback na bramkę GraphQL ma zostać uruchomiony -->
      							<iaixsl:variable name="var_show_omnibus_short_fallback"><iaixsl:choose>
      								<iaixsl:when test="($var_omnibus = '' and $var_omnibus_enabled = 'true' and not($last_price_change_date = ''))"><![CDATA[true]]></iaixsl:when>
      							</iaixsl:choose></iaixsl:variable>
      							<!-- OMNIBUS-FALLBACK-END -->
      							<!-- OMNIBUS-END -->
      
      							<div class="product__prices">
      								<iaixsl:if test="$var_omnibus != ''"><iaixsl:attribute name="class" ><![CDATA[product__prices --omnibus]]><iaixsl:if test="$var_omnibus_short = 'true'"><![CDATA[ --omnibus-short]]></iaixsl:if></iaixsl:attribute></iaixsl:if>
      
      								<!-- OMNIBUS-FALLBACK -->
      								<!-- Jeśli Omnibus z ceną nie jest zwracany w xmlu a dostępna jest data to zostaną dodane atrybuty wymagane dla mechanizmu fallbacku -->
      								<iaixsl:if test="$var_show_omnibus_short_fallback = 'true'">
      
      									<!-- Atrybut z datą ostatniej zmiany ceny -->
      									<iaixsl:attribute name="data-last_price_change_date"><iaixsl:value-of select="$last_price_change_date"/></iaixsl:attribute>
      
      									<!-- Atrybut z informacją dla mechanizmu fallbacku w jakim miejscu na stronie znajduje się atrybut z datą -->
      									<!-- Wymagane do mapowania funkcji modyfikujących strukturę HTMLa i obsługujących wyświetlanie danych z bramki GraphQL -->
      									<iaixsl:attribute name="data-omnibus-type"><![CDATA[search]]></iaixsl:attribute>
      
      									<!-- Atrybut z ID produktu -->
      									<iaixsl:if test="@id">
      										<iaixsl:attribute name="data-omnibus_product_id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
      									</iaixsl:if>
      
      									<!-- Wymagane do wyliczenia czy ma wyświetlić skróconą wersję Omnibusa -->
      									<iaixsl:if test="price/@maxprice_net">
      										<iaixsl:attribute name="data-maxprice"><iaixsl:value-of select="price/@maxprice_net"/></iaixsl:attribute>
      									</iaixsl:if>
      
      									<!-- Wymagane do wyliczenia czy ma wyświetlić skróconą wersję Omnibusa -->
      									<iaixsl:if test="sizes/prices/@size_min_maxprice_net">
      										<iaixsl:attribute name="data-sizes_min_maxprice"><iaixsl:value-of select="sizes/prices/@size_min_maxprice_net"/></iaixsl:attribute>
      									</iaixsl:if>
      
      									<!-- Wymagane do wyliczenia czy ma wyświetlić skróconą wersję Omnibusa -->
      									<iaixsl:if test="sizes/prices/@size_max_maxprice_net">
      										<iaixsl:attribute name="data-sizes_max_maxprice"><iaixsl:value-of select="sizes/prices/@size_max_maxprice_net"/></iaixsl:attribute>
      									</iaixsl:if>
      								</iaixsl:if>
      								<!-- OMNIBUS-FALLBACK-END -->
      
      								<iaixsl:choose>
      									<iaixsl:when test="(sizes/prices/@minprice_net_formatted != sizes/prices/@maxprice_net_formatted) or (sizes/prices/@minprice_unit_formatted != sizes/prices/@maxprice_unit_formatted)">
      										<iaixsl:if test="(sizes/prices/@size_min_maxprice_net_formatted != sizes/prices/@size_max_maxprice_net_formatted) or (sizes/prices/@size_min_maxprice_unit_formatted != sizes/prices/@size_max_maxprice_unit_formatted)">
      											<span class="price --max">
      												<!-- OMNIBUS -->
      												<iaixsl:if test="($var_omnibus_short != 'true') or ($var_show_omnibus_short_fallback = 'true')">
      													<span class="omnibus_label --hidden"><iaixsl:if test="$var_omnibus_short != 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_label]]></iaixsl:attribute></iaixsl:if><iai:variable vid="Cena regularna"/>: </span>
      												</iaixsl:if>
      												<!-- OMNIBUS-END -->
      												<del>
      													<iaixsl:choose>
      														<iaixsl:when test="sizes/prices/@size_min_maxprice_unit_formatted">
      															<span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_unit_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_unit_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
      														</iaixsl:when>
      														<iaixsl:otherwise>
      															<span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_net_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_net_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
      														</iaixsl:otherwise>
      													</iaixsl:choose>
      												</del>
      												<!-- OMNIBUS -->
      												<iaixsl:if test="($var_omnibus != '' and $var_omnibus_short = 'true') or ($var_show_omnibus_short_fallback = 'true')">
      													<span class="omnibus_short --hidden"><iaixsl:if test="$var_omnibus != '' and $var_omnibus_short = 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_short]]></iaixsl:attribute></iaixsl:if><iai:variable vid="Najniższa cena z 30 dni przed obniżką"/></span>
      												</iaixsl:if>
      												<!-- OMNIBUS-END -->
      											</span>
      										</iaixsl:if>
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
      
      											<iaixsl:if test="sizes/prices/@minprice_unit_formatted">
      												<iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="sizes/@unit"/>
      											</iaixsl:if>
      											<span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
      										</strong>
      										<!-- OMNIBUS -->
      										<iaixsl:if test="($var_omnibus != '' and $var_omnibus_short != 'true') or ($var_show_omnibus_short_fallback = 'true')">
      											<span class="omnibus_price --hidden"><iaixsl:if test="$var_omnibus != '' and $var_omnibus_short != 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_price]]></iaixsl:attribute></iaixsl:if><span class="omnibus_price__text"><iai:variable vid="Najniższa cena produktu w okresie 30 dni przed wprowadzeniem obniżki"/>: </span><span class="omnibus_price__value"><iaixsl:value-of select="$var_omnibus" /></span></span>
      										</iaixsl:if>
      										<!-- OMNIBUS-END -->
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
      										<iaixsl:if test="price/@maxprice_net or price/@maxprice_unit">
      											<span class="price --max">
      												<!-- OMNIBUS -->
      												<iaixsl:if test="($var_omnibus_short != 'true') or ($var_show_omnibus_short_fallback = 'true')">
      													<span class="omnibus_label --hidden"><iaixsl:if test="$var_omnibus_short != 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_label]]></iaixsl:attribute></iaixsl:if><iai:variable vid="Cena regularna"/>: </span>
      												</iaixsl:if>
      												<!-- OMNIBUS-END -->
      												<del>
      													<iaixsl:choose>
      														<iaixsl:when test="price/@maxprice_unit_formatted">
      															<iaixsl:value-of select="price/@maxprice_unit_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
      														</iaixsl:when>
      														<iaixsl:otherwise>
      															<iaixsl:value-of select="price/@maxprice_net_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
      														</iaixsl:otherwise>
      													</iaixsl:choose>
      												</del>
      												<!-- OMNIBUS -->
      												<iaixsl:if test="($var_omnibus != '' and $var_omnibus_short = 'true') or ($var_show_omnibus_short_fallback = 'true')">
      													<span class="omnibus_short --hidden"><iaixsl:if test="$var_omnibus != '' and $var_omnibus_short = 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_short]]></iaixsl:attribute></iaixsl:if><iai:variable vid="Najniższa cena z 30 dni przed obniżką"/></span>
      												</iaixsl:if>
      												<!-- OMNIBUS-END -->
      											</span>
      										</iaixsl:if>
      										<strong class="price">
      											<iaixsl:choose>
      												<iaixsl:when test="price/@price_unit_net_formatted">
      													<iaixsl:value-of select="price/@price_unit_net_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="sizes/@unit"/>
      												</iaixsl:when>
      												<iaixsl:otherwise>
      													<iaixsl:value-of select="price/@price_net_formatted"/>
      												</iaixsl:otherwise>
      											</iaixsl:choose>
      											<span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
      										</strong>
      										<iaixsl:if test="price/@points">
      											<span class="price --points"><iaixsl:value-of select="price/@points"/><span class="currency"> <iai:variable vid="PKT"/></span></span>
      										</iaixsl:if>
      										<!-- OMNIBUS -->
      										<iaixsl:if test="($var_omnibus != '' and $var_omnibus_short != 'true') or ($var_show_omnibus_short_fallback = 'true')">
      											<span class="omnibus_price --hidden"><iaixsl:if test="$var_omnibus != '' and $var_omnibus_short != 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_price]]></iaixsl:attribute></iaixsl:if><span class="omnibus_price__text"><iai:variable vid="Najniższa cena produktu w okresie 30 dni przed wprowadzeniem obniżki"/>: </span><span class="omnibus_price__value"><iaixsl:value-of select="$var_omnibus" /></span></span>
      										</iaixsl:if>
      										<!-- OMNIBUS-END -->
      									</iaixsl:otherwise>
      								</iaixsl:choose>
      
      								<!-- CENA ZA KILO -->
      								<iaixsl:if test="price/@unit_converted_price_net_formatted"><small class="price --convert"><iaixsl:value-of select="price/@unit_converted_price_net_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span></small>
      								</iaixsl:if>
      							</div>
      						</iaixsl:when>
      						<!-- Cena detaliczna -->
      						<iaixsl:otherwise>
      							<!-- OMNIBUS -->
      							<!-- Najniższa cena Omnibusa z listy rozmiarów -->
      							<iaixsl:variable name="var_omnibus_min" ><iaixsl:for-each select="sizes/size[price/@omnibus_price]">
      								<iaixsl:sort select="price/@omnibus_price" data-type="number"/>
      								<iaixsl:if test="position() = 1"><xsl:value-of select="price/@omnibus_price_formatted"/></iaixsl:if>
      							</iaixsl:for-each></iaixsl:variable>
      
      							<!-- Najwyższa cena Omnibusa z listy rozmiarów -->
      							<iaixsl:variable name="var_omnibus_max" ><iaixsl:for-each select="sizes/size[price/@omnibus_price]">
      								<iaixsl:sort select="price/@omnibus_price" data-type="number" order="descending"/>
      								<iaixsl:if test="position() = 1"><xsl:value-of select="price/@omnibus_price_formatted"/></iaixsl:if>
      							</iaixsl:for-each></iaixsl:variable>
      
      							<!-- Cena lub przedział Omnibusa w zależności od tego czy najniższa i najwyższa cena Omnibusa są od siebie różne -->
      							<iaixsl:variable name="var_omnibus"><iaixsl:if test="$var_omnibus_enabled = 'true'"><iaixsl:choose>
      								<iaixsl:when test="$var_omnibus_min != $var_omnibus_max">
      									<span><iaixsl:value-of select="$var_omnibus_min"/></span><b><iaixsl:text><![CDATA[ - ]]></iaixsl:text></b><span><iaixsl:value-of select="$var_omnibus_max"/></span>
      								</iaixsl:when>
      								<iaixsl:when test="$var_omnibus_min != ''">
      									<iaixsl:value-of select="$var_omnibus_min" />
      								</iaixsl:when>
      								<iaixsl:when test="@product_type = 'virtual' and (count(sizes/size[price/@omnibus_price]) = 0) and price/@omnibus_price_formatted">
      									<iaixsl:value-of select="price/@omnibus_price_formatted" />
      								</iaixsl:when>
      							</iaixsl:choose></iaixsl:if></iaixsl:variable>
      
      							<!-- Zmienna przechowująca informację czy ma być wyświetlona skrócona wersja Omnibusa -->
      							<iaixsl:variable name="var_omnibus_short"><iaixsl:if test="$var_omnibus_enabled = 'true'"><iaixsl:choose>
      								<iaixsl:when test="sizes/prices/@size_min_maxprice_formatted != sizes/prices/@size_max_maxprice_formatted and sizes/prices/@size_min_maxprice_formatted = $var_omnibus_min and sizes/prices/@size_max_maxprice_formatted = $var_omnibus_max"><![CDATA[true]]></iaixsl:when>
      								<iaixsl:when test="price/@maxprice_formatted = $var_omnibus"><![CDATA[true]]></iaixsl:when>
      							</iaixsl:choose></iaixsl:if></iaixsl:variable>
      
      							<!-- OMNIBUS-FALLBACK -->
      							<!-- Zmienna przechowująca tablicę dat wszystkich rozmiarów w formacie [data; typ rozmiaru #separator# data; typ rozmiaru] -->
      							<!-- Jeśli ilość rozmiarów jest mniejsza niż 1 lub rozmiary nie zawierają atrybutu z datą ostatniej zmiany ceny to zostanie użyta data z węzła /product/price -->
      							<iaixsl:variable name="last_price_change_date"><iaixsl:choose>
      								<iaixsl:when test="sizes/size/price and (count(sizes/size) &gt; 1)"><iaixsl:for-each select="sizes/size[price/@last_price_change_date]"><iaixsl:if test="@type and price/@last_price_change_date"><iaixsl:value-of select="price/@last_price_change_date"/><![CDATA[;']]><iaixsl:value-of select="@type"/><![CDATA[']]><iaixsl:if test="not(position() = last())"><![CDATA[#separator#]]></iaixsl:if></iaixsl:if></iaixsl:for-each></iaixsl:when>
      								<iaixsl:when test="price/@last_price_change_date"><iaixsl:value-of select="price/@last_price_change_date"/></iaixsl:when>
      							</iaixsl:choose></iaixsl:variable>
      
      							<!-- Zmienna przechowująca informację czy fallback na bramkę GraphQL ma zostać uruchomiony -->
      							<iaixsl:variable name="var_show_omnibus_short_fallback"><iaixsl:choose>
      								<iaixsl:when test="($var_omnibus = '' and $var_omnibus_enabled = 'true' and not($last_price_change_date = ''))"><![CDATA[true]]></iaixsl:when>
      							</iaixsl:choose></iaixsl:variable>
      							<!-- OMNIBUS-FALLBACK-END -->
      							<!-- OMNIBUS-END -->
      
      							<div class="product__prices">
      								<iaixsl:if test="$var_omnibus != ''"><iaixsl:attribute name="class" ><![CDATA[product__prices --omnibus]]><iaixsl:if test="$var_omnibus_short = 'true'"><![CDATA[ --omnibus-short]]></iaixsl:if></iaixsl:attribute></iaixsl:if>
      
      								<!-- OMNIBUS-FALLBACK -->
      								<!-- Jeśli Omnibus z ceną nie jest zwracany w xmlu a dostępna jest data to zostaną dodane atrybuty wymagane dla mechanizmu fallbacku -->
      								<iaixsl:if test="$var_show_omnibus_short_fallback = 'true'">
      
      									<!-- Atrybut z datą ostatniej zmiany ceny -->
      									<iaixsl:attribute name="data-last_price_change_date"><iaixsl:value-of select="$last_price_change_date"/></iaixsl:attribute>
      
      									<!-- Atrybut z informacją dla mechanizmu fallbacku w jakim miejscu na stronie znajduje się atrybut z datą -->
      									<!-- Wymagane do mapowania funkcji modyfikujących strukturę HTMLa i obsługujących wyświetlanie danych z bramki GraphQL -->
      									<iaixsl:attribute name="data-omnibus-type"><![CDATA[search]]></iaixsl:attribute>
      
      									<!-- Atrybut z ID produktu -->
      									<iaixsl:if test="@id">
      										<iaixsl:attribute name="data-omnibus_product_id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
      									</iaixsl:if>
      
      									<!-- Wymagane do wyliczenia czy ma wyświetlić skróconą wersję Omnibusa -->
      									<iaixsl:if test="price/@maxprice">
      										<iaixsl:attribute name="data-maxprice"><iaixsl:value-of select="price/@maxprice"/></iaixsl:attribute>
      									</iaixsl:if>
      
      									<!-- Wymagane do wyliczenia czy ma wyświetlić skróconą wersję Omnibusa -->
      									<iaixsl:if test="sizes/prices/@size_min_maxprice">
      										<iaixsl:attribute name="data-sizes_min_maxprice"><iaixsl:value-of select="sizes/prices/@size_min_maxprice"/></iaixsl:attribute>
      									</iaixsl:if>
      
      									<!-- Wymagane do wyliczenia czy ma wyświetlić skróconą wersję Omnibusa -->
      									<iaixsl:if test="sizes/prices/@size_max_maxprice">
      										<iaixsl:attribute name="data-sizes_max_maxprice"><iaixsl:value-of select="sizes/prices/@size_max_maxprice"/></iaixsl:attribute>
      									</iaixsl:if>
      								</iaixsl:if>
      								<!-- OMNIBUS-FALLBACK-END -->
      
      								<iaixsl:choose>
      									<iaixsl:when test="(sizes/prices/@minprice_formatted != sizes/prices/@maxprice_formatted) or (sizes/prices/@minprice_unit_formatted != sizes/prices/@maxprice_unit_formatted)">
      										<iaixsl:if test="(sizes/prices/@size_min_maxprice_formatted != sizes/prices/@size_max_maxprice_formatted) or (sizes/prices/@size_min_maxprice_unit_formatted != sizes/prices/@size_max_maxprice_unit_formatted)">
      											<span class="price --max">
      												<!-- OMNIBUS -->
      												<iaixsl:if test="($var_omnibus_short != 'true') or ($var_show_omnibus_short_fallback = 'true')">
      													<span class="omnibus_label --hidden"><iaixsl:if test="$var_omnibus_short != 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_label]]></iaixsl:attribute></iaixsl:if><iai:variable vid="Cena regularna"/>: </span>
      												</iaixsl:if>
      												<!-- OMNIBUS-END -->
      												<del>
      													<iaixsl:choose>
      														<iaixsl:when test="sizes/prices/@size_min_maxprice_unit_formatted">
      															<span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_unit_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_unit_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
      														</iaixsl:when>
      														<iaixsl:otherwise>
      															<span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
      														</iaixsl:otherwise>
      													</iaixsl:choose>
      												</del>
      												<!-- OMNIBUS -->
      												<iaixsl:if test="($var_omnibus != '' and $var_omnibus_short = 'true') or ($var_show_omnibus_short_fallback = 'true')">
      													<span class="omnibus_short --hidden"><iaixsl:if test="$var_omnibus != '' and $var_omnibus_short = 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_short]]></iaixsl:attribute></iaixsl:if><iai:variable vid="Najniższa cena z 30 dni przed obniżką"/></span>
      												</iaixsl:if>
      												<!-- OMNIBUS-END -->
      											</span>
      										</iaixsl:if>
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
      
      											<iaixsl:if test="sizes/prices/@minprice_unit_formatted">
      												<iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="sizes/@unit"/>
      											</iaixsl:if>
      											<span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
      										</strong>
      										<!-- OMNIBUS -->
      										<iaixsl:if test="($var_omnibus != '' and $var_omnibus_short != 'true') or ($var_show_omnibus_short_fallback = 'true')">
      											<span class="omnibus_price --hidden"><iaixsl:if test="$var_omnibus != '' and $var_omnibus_short != 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_price]]></iaixsl:attribute></iaixsl:if><span class="omnibus_price__text"><iai:variable vid="Najniższa cena produktu w okresie 30 dni przed wprowadzeniem obniżki"/>: </span><span class="omnibus_price__value"><iaixsl:value-of select="$var_omnibus" /></span></span>
      										</iaixsl:if>
      										<!-- OMNIBUS-END -->
      									</iaixsl:when>
      									<iaixsl:when test="(sizes/prices/@minprice = 0) and not(price/@points)">
      										<a class="price --phone">
      											<iaixsl:attribute name="title"><iai:variable vid="Kliknij, by przejść do formularza kontaktu"/></iaixsl:attribute>
      											<iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/contact/@url"/></iaixsl:attribute>
      											<iai:variable vid="Cena na telefon"/>
      										</a>
      									</iaixsl:when>
      									<iaixsl:otherwise>
      										<iaixsl:if test="price/@maxprice or price/@maxprice_unit">
      											<span class="price --max">
      												<!-- OMNIBUS -->
      												<iaixsl:if test="($var_omnibus_short != 'true') or ($var_show_omnibus_short_fallback = 'true')">
      													<span class="omnibus_label --hidden"><iaixsl:if test="$var_omnibus_short != 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_label]]></iaixsl:attribute></iaixsl:if><iai:variable vid="Cena regularna"/>: </span>
      												</iaixsl:if>
      												<!-- OMNIBUS-END -->
      												<del>
      													<iaixsl:choose>
      														<iaixsl:when test="price/@maxprice_unit_formatted">
      															<iaixsl:value-of select="price/@maxprice_unit_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
      														</iaixsl:when>
      														<iaixsl:otherwise>
      															<iaixsl:value-of select="price/@maxprice_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
      														</iaixsl:otherwise>
      													</iaixsl:choose>
      												</del>
      												<!-- OMNIBUS -->
      												<iaixsl:if test="($var_omnibus != '' and $var_omnibus_short = 'true') or ($var_show_omnibus_short_fallback = 'true')">
      													<span class="omnibus_short --hidden"><iaixsl:if test="$var_omnibus != '' and $var_omnibus_short = 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_short]]></iaixsl:attribute></iaixsl:if><iai:variable vid="Najniższa cena z 30 dni przed obniżką"/></span>
      												</iaixsl:if>
      												<!-- OMNIBUS-END -->
      											</span>
      										</iaixsl:if>
      										<strong class="price">
      											<iaixsl:choose>
      												<iaixsl:when test="price/@price_unit_formatted">
      													<iaixsl:value-of select="price/@price_unit_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="sizes/@unit"/>
      												</iaixsl:when>
      												<iaixsl:otherwise>
      													<iaixsl:value-of select="sizes/prices/@minprice_formatted"/>
      													<span class="price__unit"><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit"/></span>
      												</iaixsl:otherwise>
      											</iaixsl:choose>
      											<span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
      										</strong>
      
      										<iaixsl:if test="price/@points">
      											<span class="price --points"><iaixsl:value-of select="price/@points"/><span class="currency"> <iai:variable vid="PKT"/></span></span>
      										</iaixsl:if>
      										<!-- OMNIBUS -->
      										<iaixsl:if test="($var_omnibus != '' and $var_omnibus_short != 'true') or ($var_show_omnibus_short_fallback = 'true')">
      											<span class="omnibus_price --hidden"><iaixsl:if test="$var_omnibus != '' and $var_omnibus_short != 'true'"><iaixsl:attribute name="class"><![CDATA[omnibus_price]]></iaixsl:attribute></iaixsl:if><span class="omnibus_price__text"><iai:variable vid="Najniższa cena produktu w okresie 30 dni przed wprowadzeniem obniżki"/>: </span><span class="omnibus_price__value"><iaixsl:value-of select="$var_omnibus" /></span></span>
      										</iaixsl:if>
      										<!-- OMNIBUS-END -->
      									</iaixsl:otherwise>
      								</iaixsl:choose>
      
      								<!-- CENA ZA KILO -->
      								<iaixsl:if test="price/@unit_converted_price_formatted"><small class="price --convert"><iaixsl:value-of select="price/@unit_converted_price_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span></small>
      								</iaixsl:if>
      							</div>
      						</iaixsl:otherwise>
      					</iaixsl:choose>
  			      </div>
			      </div>
			      <div class="product__info__row">
			        <div class="product__info__col --omnibus"></div>
			      </div>
			    </div>

					<!-- DO PORÓWNANIA -->
					<iaixsl:if test="/shop/compare/@active = 'y' and $addcompare_txt">
					  <div class="product__compare">
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
						</div>
					</iaixsl:if>
					
					<!-- ROZMIARY -->
					<div class="product__sizes d-none">
						<div class="product__sizes__sub">
							<iaixsl:for-each select="sizes/size">
								<iaixsl:choose>
									<iaixsl:when test="(@amount &gt; 0) or (@amount = '-1')">
										<a class="product__sizes__button">
											<iaixsl:if test="@selected='true'">
												<iaixsl:attribute name="class"><![CDATA[product__sizes__button --active]]></iaixsl:attribute>
											</iaixsl:if>
											<iaixsl:attribute name="data-type">
												<iaixsl:value-of select="@type"/>
											</iaixsl:attribute>
											<iaixsl:value-of select="@description"/>
										</a>
									</iaixsl:when>
									<iaixsl:otherwise>
										<a class="product__sizes__button --disabled">
											<iaixsl:if test="@selected='true'">
												<iaixsl:attribute name="class"><![CDATA[product__sizes__button --disabled --active]]></iaixsl:attribute>
											</iaixsl:if>
											<iaixsl:attribute name="data-type">
												<iaixsl:value-of select="@type"/>
											</iaixsl:attribute>
											<iaixsl:value-of select="@description"/>
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
			</iaixsl:for-each>
		</section>
	</iaixsl:if>
	<iaixsl:if test="/shop/page/search_params/*"> </iaixsl:if>
<cdata-end/></iai:componentsdata></iai:component>

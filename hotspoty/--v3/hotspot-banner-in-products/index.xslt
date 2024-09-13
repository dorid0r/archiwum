<?xml version="1.0" encoding="UTF-8"?><iai:component><iai:componentsdata><cdata-start/>
	<iaiajaxstart iai-ajax-id="main_hotspot_zone2" iai-ajax-generated="true"/>
		<iaixsl:if test="page/hotspot/products_zone2">
			<section id="main_hotspot_zone2" class="hotspot mb-5">
				<!-- Variables -->
				<iaixsl:variable name="headline_after_products_zone2"><iai:variable vid="Zobacz wszystkie"/></iaixsl:variable>
				<!-- Atrybuty pod ajax hotspot -->
				<iaixsl:if test="not(page/hotspot/products_zone2/product or page/hotspot/products_zone2/opinion)">
					<iaixsl:attribute name="data-ajaxLoad"><![CDATA[true]]></iaixsl:attribute>
					<iaixsl:attribute name="data-pageType"><![CDATA[main]]></iaixsl:attribute>
				</iaixsl:if>

        <!-- OMNIBUS -->
				<!-- Zmienna przechowująca stan Omnibusa - włączony (omnibus = 1) / wyłączony -->
        <iaixsl:variable name="var_omnibus_enabled"><iaixsl:if test="/shop/@omnibus = 1"><![CDATA[true]]></iaixsl:if></iaixsl:variable>
				<!-- OMNIBUS-END -->

				<iaixsl:choose>
					<iaixsl:when test="page/hotspot/products_zone2/product or page/hotspot/products_zone2/opinion">
						<!-- Nazwa hotspotu -->
						<h2>
							<iaixsl:choose>
								<iaixsl:when test="page/hotspot/products_zone2/@link">
									<a class="headline">
										<iaixsl:attribute name="href"><iaixsl:value-of select="page/hotspot/products_zone2/@link"/></iaixsl:attribute>
										<iaixsl:attribute name="title"><iai:variable vid="Kliknij aby zobaczyć wszystkie produkty"/> </iaixsl:attribute>

										<span class="headline__name">
											<iaixsl:choose>
												<iaixsl:when test="page/hotspot/products_zone2/@name"><iaixsl:value-of select="page/hotspot/products_zone2/@name"/></iaixsl:when>
												<iaixsl:otherwise><iai:variable vid="Nowości"/> </iaixsl:otherwise>
											</iaixsl:choose>
										</span>
										<iaixsl:if test="$headline_after_products_zone2">
											<span class="headline__after"><iaixsl:value-of select="$headline_after_products_zone2"/></span>
										</iaixsl:if>
									</a>
								</iaixsl:when>
								<iaixsl:otherwise>
									<span class="headline">
										<span class="headline__name">
											<iaixsl:choose>
												<iaixsl:when test="page/hotspot/products_zone2/@name"><iaixsl:value-of select="page/hotspot/products_zone2/@name"/></iaixsl:when>
												<iaixsl:otherwise><iai:variable vid="Nowości"/> </iaixsl:otherwise>
											</iaixsl:choose>
										</span>
									</span>
								</iaixsl:otherwise>
							</iaixsl:choose>
						</h2>

						<div class="products d-flex flex-wrap">
							<iaixsl:for-each select="page/hotspot/products_zone2/*">
								<!-- Local Variables -->
								<iaixsl:variable name="var_id"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/@id"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="@id"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
								<iaixsl:variable name="var_name"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of disable-output-escaping="yes" select="product/name/text()"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of disable-output-escaping="yes" select="name/text()"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
								<iaixsl:variable name="var_icon"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/icon"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="icon"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
								<iaixsl:variable name="var_icon_small"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/icon_small"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="icon_small"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
								<iaixsl:variable name="var_link"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/@link"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="@link"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
								<iaixsl:variable name="var_yousave"></iaixsl:variable>
								<iaixsl:variable name="var_net_prices"><iaixsl:if test="/shop/page/@price_type = 'net'"> <iai:variable vid="netto"/></iaixsl:if></iaixsl:variable>
								<iaixsl:variable name="var_gross_prices"><iaixsl:if test="/shop/page/@price_type = 'gross'"> <iai:variable vid="brutto"/></iaixsl:if></iaixsl:variable>
								<iaixsl:variable name="var_icon_second"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/icon_second"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="icon_second"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
								<iaixsl:variable name="var_icon_small_second"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/icon_small_second"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="icon_small_second"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
								<iaixsl:variable name="var_b2b"></iaixsl:variable>
								<iaixsl:variable name="var_unit"><iaixsl:choose><iaixsl:when test="product"><iaixsl:choose><iaixsl:when test="not(product/price/@price_unit_formatted)"><iaixsl:value-of select="product/sizes/@unit_single"/></iaixsl:when><iaixsl:when test="product/sizes/@unit_sellby &gt; 1"><iaixsl:value-of select="product/sizes/@unit_plural"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="product/sizes/@unit_single"/></iaixsl:otherwise></iaixsl:choose></iaixsl:when><iaixsl:otherwise><iaixsl:choose><iaixsl:when test="not(price/@price_unit_formatted)"><iaixsl:value-of select="sizes/@unit_single"/></iaixsl:when><iaixsl:when test="sizes/@unit_sellby &gt; 1"><iaixsl:value-of select="sizes/@unit_plural"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="sizes/@unit_single"/></iaixsl:otherwise></iaixsl:choose></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
								<iaixsl:variable name="var_sellby"><iaixsl:choose><iaixsl:when test="product"><iaixsl:choose><iaixsl:when test="not(product/price/@price_unit_formatted)"><![CDATA[1]]></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="product/sizes/@unit_sellby"/></iaixsl:otherwise></iaixsl:choose></iaixsl:when><iaixsl:otherwise><iaixsl:choose><iaixsl:when test="not(price/@price_unit_formatted)"><![CDATA[1]]></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="sizes/@unit_sellby"/></iaixsl:otherwise></iaixsl:choose></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
                
								<div class="product col-6 col-sm-3 col-xl-2 py-3">
									<!-- YOUSAVE - aktywowane literałem label oszczędzasz XXX -->
									<iaixsl:if test="$var_yousave and not($var_yousave = '') and price/@yousave_formatted != ''">
										<div class="product__yousave">
											<span class="product__yousave --label"><iaixsl:value-of select="$var_yousave"/></span>
											<span class="product__yousave --value"><iaixsl:value-of select="price/@yousave_formatted"/></span>
										</div>
									</iaixsl:if>

									<!-- IKONA PRODUKTU -->
									<a class="product__icon d-flex justify-content-center align-items-center">
										<iaixsl:attribute name="data-product-id"><iaixsl:value-of select="$var_id"/></iaixsl:attribute>
										<iaixsl:attribute name="href"><iaixsl:value-of select="$var_link"/></iaixsl:attribute>
										<iaixsl:attribute name="title"><iaixsl:value-of select="$var_name"/></iaixsl:attribute>

                    <iaixsl:choose>
                      <iaixsl:when test="$var_icon_second and not($var_icon_second = '/' or $var_icon_second = '') and $var_icon_small_second and not($var_icon_small_second = '/' or $var_icon_small_second = '')">
                        <picture>
                          <source media="(min-width: 421px)" type="image/webp">
                            <iaixsl:attribute name="srcset"><iaixsl:value-of select="$var_icon"/></iaixsl:attribute>
                          </source>
                          <source media="(min-width: 421px)" type="image/jpeg">
                            <iaixsl:attribute name="srcset"><iaixsl:value-of select="$var_icon_second"/></iaixsl:attribute>
                          </source>
                          <source media="(max-width: 420px)" type="image/webp">
                            <iaixsl:attribute name="srcset"><iaixsl:value-of select="$var_icon_small"/></iaixsl:attribute>
                          </source>

                          <img src="/gfx/pol/loader.gif?r=1642670063" class="b-lazy">
                            <iaixsl:attribute name="data-src-small"><iaixsl:value-of disable-output-escaping="yes" select="$var_icon_small_second"/></iaixsl:attribute>
                            <iaixsl:attribute name="data-src"><iaixsl:value-of disable-output-escaping="yes" select="$var_icon_second"/></iaixsl:attribute>
                            <iaixsl:attribute name="alt"><iaixsl:value-of disable-output-escaping="yes" select="$var_name"/></iaixsl:attribute>
                          </img>

                        </picture>
                      </iaixsl:when>
                      <iaixsl:otherwise>
                        <img src="/gfx/pol/loader.gif?r=1642670063" class="b-lazy">
                          <iaixsl:attribute name="data-src-small"><iaixsl:value-of disable-output-escaping="yes" select="$var_icon_small"/></iaixsl:attribute>
                          <iaixsl:attribute name="data-src"><iaixsl:value-of disable-output-escaping="yes" select="$var_icon"/></iaixsl:attribute>
                          <iaixsl:attribute name="alt"><iaixsl:value-of disable-output-escaping="yes" select="$var_name"/></iaixsl:attribute>
                        </img>
                      </iaixsl:otherwise>
                    </iaixsl:choose>
									</a>

									<!-- NAZWA PRODUKTU -->
									<h3>
										<a class="product__name">
											<iaixsl:attribute name="href"><iaixsl:value-of select="$var_link"/></iaixsl:attribute>
											<iaixsl:attribute name="title"><iaixsl:value-of select="$var_name"/></iaixsl:attribute>
											<iaixsl:value-of select="$var_name"/>
										</a>
									</h3>

									<iaixsl:choose>
										<!-- CENA BRUTTO -->
										<iaixsl:when test="$var_net_prices = ''">
											<iaixsl:variable name="var_size_min_formatted"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/price/@size_min_formatted"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="price/@size_min_formatted"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
											<iaixsl:variable name="var_size_max_formatted"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/price/@size_max_formatted"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="price/@size_max_formatted"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
											<iaixsl:variable name="var_points"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/price/@points"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="price/@points"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>

											<iaixsl:variable name="var_value"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/price/@size_min"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="price/@size_min"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
											<iaixsl:variable name="var_price_formatted">
												<iaixsl:choose>
													<iaixsl:when test="price/@price_unit_formatted and sizes/@unit"><iaixsl:value-of select="price/@price_unit_formatted"/></iaixsl:when>
													<iaixsl:when test="product/price/@price_unit_formatted and product/sizes/@unit"><iaixsl:value-of select="product/price/@price_unit_formatted"/></iaixsl:when>
													<iaixsl:otherwise><iaixsl:value-of select="$var_size_min_formatted"/></iaixsl:otherwise>
												</iaixsl:choose>
											</iaixsl:variable>

											<iaixsl:variable name="var_maxprice_formatted">
												<iaixsl:choose>
													<iaixsl:when test="price/@maxprice_unit_formatted"><iaixsl:value-of select="price/@maxprice_unit_formatted"/></iaixsl:when>
													<iaixsl:when test="product/price/@maxprice_unit_formatted"><iaixsl:value-of select="product/price/@maxprice_unit_formatted"/></iaixsl:when>
													<iaixsl:when test="product"><iaixsl:value-of select="product/price/@maxprice_formatted"/></iaixsl:when>
													<iaixsl:otherwise><iaixsl:value-of select="price/@maxprice_formatted"/></iaixsl:otherwise>
												</iaixsl:choose>
											</iaixsl:variable>

											<!-- OMNIBUS -->
											<!-- Najniższa cena Omnibusa z listy rozmiarów -->
											<iaixsl:variable name="var_omnibus_min" ><iaixsl:choose>
												<iaixsl:when test="product and product/sizes/size/price and product/sizes/size[price/@omnibus_price_unit]">
													<iaixsl:for-each select="product/sizes/size[price/@omnibus_price_unit]">
														<iaixsl:sort select="price/@omnibus_price_unit" data-type="number"/>
														<iaixsl:if test="position() = 1"><iaixsl:value-of select="price/@omnibus_price_unit_formatted"/></iaixsl:if>
													</iaixsl:for-each>
												</iaixsl:when>
												<iaixsl:when test="product and product/price/@omnibus_price_unit_formatted">
													<iaixsl:value-of select="product/price/@omnibus_price_unit_formatted"/>
												</iaixsl:when>
												<iaixsl:when test="product and product/sizes/size/price">
													<iaixsl:for-each select="product/sizes/size[price/@omnibus_price]">
														<iaixsl:sort select="price/@omnibus_price" data-type="number"/>
														<iaixsl:if test="position() = 1"><iaixsl:value-of select="price/@omnibus_price_formatted"/></iaixsl:if>
													</iaixsl:for-each>
												</iaixsl:when>
												<iaixsl:when test="product">
													<iaixsl:value-of select="product/price/@omnibus_price_formatted"/>
												</iaixsl:when>
												<iaixsl:when test="sizes/size[price/@omnibus_price_unit]">
													<iaixsl:for-each select="sizes/size[price/@omnibus_price_unit]">
														<iaixsl:sort select="price/@omnibus_price_unit" data-type="number"/>
														<iaixsl:if test="position() = 1"><iaixsl:value-of select="price/@omnibus_price_unit_formatted"/></iaixsl:if>
													</iaixsl:for-each>
												</iaixsl:when>
												<iaixsl:when test="price/@omnibus_price_unit_formatted">
													<iaixsl:value-of select="price/@omnibus_price_unit_formatted"/>
												</iaixsl:when>
												<iaixsl:when test="sizes/size/price">
													<iaixsl:for-each select="sizes/size[price/@omnibus_price]">
														<iaixsl:sort select="price/@omnibus_price" data-type="number"/>
														<iaixsl:if test="position() = 1"><iaixsl:value-of select="price/@omnibus_price_formatted"/></iaixsl:if>
													</iaixsl:for-each>
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="price/@omnibus_price_formatted"/>
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:variable>

											<!-- Cena Omnibusa  -->
											<iaixsl:variable name="var_omnibus"><iaixsl:if test="$var_omnibus_enabled = 'true'">
												<iaixsl:choose>
													<!-- Czy ceny są różne, jeżeli tak to nie ma omnibusa -->
													<iaixsl:when test="$var_size_min_formatted != $var_size_max_formatted"></iaixsl:when>
													<iaixsl:when test="$var_omnibus_min != ''"><iaixsl:value-of select="$var_omnibus_min" /></iaixsl:when>
												</iaixsl:choose>
											</iaixsl:if></iaixsl:variable>

											<!-- Zmienna przechowująca informację czy ma być wyświetlona skrócona wersja Omnibusa -->
											<iaixsl:variable name="var_omnibus_short"><iaixsl:if test="$var_omnibus_enabled = 'true' and $var_maxprice_formatted = $var_omnibus"><![CDATA[true]]></iaixsl:if></iaixsl:variable>
											<!-- OMNIBUS-END -->

											<div class="product__prices --omnibus-new">
												<iaixsl:if test="$var_omnibus != ''"><iaixsl:attribute name="class" ><![CDATA[product__prices --omnibus-new --omnibus]]><iaixsl:if test="$var_omnibus_short = 'true'"><![CDATA[ --omnibus-short]]></iaixsl:if></iaixsl:attribute></iaixsl:if>

												<iaixsl:choose>
													<!-- Zakres ceny od - do -->
													<iaixsl:when test="$var_size_min_formatted != $var_size_max_formatted">
														<strong class="price">
															<span class="price__range --min"><iaixsl:value-of select="$var_size_min_formatted"/></span><iaixsl:text><![CDATA[ - ]]></iaixsl:text><span class="price__range --max"><iaixsl:value-of select="$var_size_max_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_gross_prices"/></span><span class="price_sellby"><span class="price_sellby__sep"><iaixsl:text><![CDATA[/]]></iaixsl:text></span><span class="price_sellby__sellby" data-sellby="{$var_sellby}"><iaixsl:value-of select="$var_sellby"/></span><span class="price_sellby__unit"><iaixsl:value-of select="$var_unit"/></span></span>
														</strong>
														<iaixsl:if test="$var_points != ''">
															<span class="price --points">
																<iaixsl:value-of select="$var_points"/><span class="currency"> <iai:variable vid="pkt"/>.</span>
															</span>
														</iaixsl:if>
													</iaixsl:when>

													<!-- Cena na telefon -->
													<iaixsl:when test="(($var_value = 0) and $var_points = '') or ($var_value = 0 and $var_b2b and not($var_b2b = '') and not(/shop/basket/@wholesaler = 'true'))">
														<iaixsl:choose>
															<iaixsl:when test="$var_b2b and not($var_b2b = '')">
																<a class="price --phone" href="/signin.php">
																	<iaixsl:attribute name="title"><iaixsl:value-of select="$var_b2b"/></iaixsl:attribute>
																	<iaixsl:value-of select="$var_b2b"/>
																</a>
															</iaixsl:when>
															<iaixsl:otherwise>
																<a class="price --phone" href="/contact.php">
																	<iaixsl:attribute name="title"><iai:variable vid="Kliknij, by przejść do formularza kontaktu"/></iaixsl:attribute>
																	<iai:variable vid="Cena na telefon"/>
																</a>
															</iaixsl:otherwise>
														</iaixsl:choose>
													</iaixsl:when>

													<!-- Domyślna cena -->
													<iaixsl:otherwise>
														<strong class="price">
															<iaixsl:value-of select="$var_price_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices"/></span><span class="price_sellby"><span class="price_sellby__sep"><iaixsl:text><![CDATA[/]]></iaixsl:text></span><span class="price_sellby__sellby" data-sellby="{$var_sellby}"><iaixsl:value-of select="$var_sellby"/></span><span class="price_sellby__unit"><iaixsl:value-of select="$var_unit"/></span></span>
														</strong>
														<iaixsl:if test="$var_points != ''">
															<span class="price --points">
																<iaixsl:value-of select="$var_points"/><span class="currency"> <iai:variable vid="pkt"/>.</span>
															</span>
														</iaixsl:if>
														<!-- OMNIBUS -->
														<iaixsl:if test="$var_omnibus != ''">
															<span class="omnibus_price"><span class="omnibus_price__text"><iai:variable vid="Najniższa cena produktu w okresie 30 dni przed wprowadzeniem obniżki"/> </span><del class="omnibus_price__value"><iaixsl:value-of select="$var_omnibus" /></del><span class="price_sellby"><span class="price_sellby__sep"><iaixsl:text><![CDATA[/]]></iaixsl:text></span><span class="price_sellby__sellby" data-sellby="{$var_sellby}"><iaixsl:value-of select="$var_sellby"/></span><span class="price_sellby__unit"><iaixsl:value-of select="$var_unit"/></span></span></span>
														</iaixsl:if>
														<!-- OMNIBUS-END -->
														<iaixsl:if test="$var_maxprice_formatted != ''">
															<span class="price --max">
																<span class="omnibus_label"><iai:variable vid="Cena regularna"/> </span>
																<del>
																	<iaixsl:value-of select="$var_maxprice_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices"/></span>
																</del><span class="price_sellby"><span class="price_sellby__sep"><iaixsl:text><![CDATA[/]]></iaixsl:text></span><span class="price_sellby__sellby" data-sellby="{$var_sellby}"><iaixsl:value-of select="$var_sellby"/></span><span class="price_sellby__unit"><iaixsl:value-of select="$var_unit"/></span></span>
															</span>
														</iaixsl:if>
													</iaixsl:otherwise>
												</iaixsl:choose>
                        <iaixsl:if test="price/@unit_converted_price_formatted or product/price/@unit_converted_price_formatted ">
                          <small class="price --convert"><![CDATA[(]]><iaixsl:value-of select="price/@unit_converted_price_formatted"/><iaixsl:value-of select="product/price/@unit_converted_price_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices"/></span><![CDATA[)]]></small>
                        </iaixsl:if>
											</div>
										</iaixsl:when>

										<!-- CENA NETTO -->
										<iaixsl:otherwise>
											<iaixsl:variable name="var_size_min_net_formatted"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/price/@size_min_net_formatted"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="price/@size_min_net_formatted"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
											<iaixsl:variable name="var_size_max_net_formatted"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/price/@size_max_net_formatted"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="price/@size_max_net_formatted"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
											<iaixsl:variable name="var_points_net"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/price/@points"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="price/@points"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>

											<iaixsl:variable name="var_net_value"><iaixsl:choose><iaixsl:when test="product"><iaixsl:value-of select="product/price/@size_min_net"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="price/@size_min_net"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
											<iaixsl:variable name="var_price_net_formatted">
												<iaixsl:choose>
													<iaixsl:when test="price/@price_unit_net_formatted and sizes/@unit"><iaixsl:value-of select="price/@price_unit_net_formatted"/></iaixsl:when>
													<iaixsl:when test="product/price/@price_unit_net_formatted and product/sizes/@unit"><iaixsl:value-of select="product/price/@price_unit_net_formatted"/></iaixsl:when>
													<iaixsl:otherwise><iaixsl:value-of select="$var_size_min_net_formatted"/></iaixsl:otherwise>
												</iaixsl:choose>
											</iaixsl:variable>

											<iaixsl:variable name="var_maxprice_net_formatted">
												<iaixsl:choose>
													<iaixsl:when test="price/@maxprice_unit_net_formatted"><iaixsl:value-of select="price/@maxprice_unit_net_formatted"/></iaixsl:when>
													<iaixsl:when test="product/price/@maxprice_unit_net_formatted"><iaixsl:value-of select="product/price/@maxprice_unit_net_formatted"/></iaixsl:when>
													<iaixsl:when test="product"><iaixsl:value-of select="product/price/@maxprice_net_formatted"/></iaixsl:when>
													<iaixsl:otherwise><iaixsl:value-of select="price/@maxprice_net_formatted"/></iaixsl:otherwise>
												</iaixsl:choose>
											</iaixsl:variable>

											<!-- OMNIBUS -->
											<!-- Najniższa cena Omnibusa z listy rozmiarów -->
											<iaixsl:variable name="var_omnibus_min" ><iaixsl:choose>
												<iaixsl:when test="product and product/sizes/size/price and product/sizes/size[price/@omnibus_price_unit_net]">
													<iaixsl:for-each select="product/sizes/size[price/@omnibus_price_unit_net]">
														<iaixsl:sort select="price/@omnibus_price_unit_net" data-type="number"/>
														<iaixsl:if test="position() = 1"><iaixsl:value-of select="price/@omnibus_price_unit_net_formatted"/></iaixsl:if>
													</iaixsl:for-each>
												</iaixsl:when>
												<iaixsl:when test="product and product/price/@omnibus_price_unit_net_formatted">
													<iaixsl:value-of select="product/price/@omnibus_price_unit_net_formatted"/>
												</iaixsl:when>
												<iaixsl:when test="product and product/sizes/size/price">
													<iaixsl:for-each select="product/sizes/size[price/@omnibus_price_net]">
														<iaixsl:sort select="price/@omnibus_price_net" data-type="number"/>
														<iaixsl:if test="position() = 1"><iaixsl:value-of select="price/@omnibus_price_net_formatted"/></iaixsl:if>
													</iaixsl:for-each>
												</iaixsl:when>
												<iaixsl:when test="product">
													<iaixsl:value-of select="product/price/@omnibus_price_net_formatted"/>
												</iaixsl:when>
												<iaixsl:when test="sizes/size[price/@omnibus_price_unit_net]">
													<iaixsl:for-each select="sizes/size[price/@omnibus_price_unit_net]">
														<iaixsl:sort select="price/@omnibus_price_unit_net" data-type="number"/>
														<iaixsl:if test="position() = 1"><iaixsl:value-of select="price/@omnibus_price_unit_net_formatted"/></iaixsl:if>
													</iaixsl:for-each>
												</iaixsl:when>
												<iaixsl:when test="price/@omnibus_price_unit_net_formatted">
													<iaixsl:value-of select="price/@omnibus_price_unit_net_formatted"/>
												</iaixsl:when>
												<iaixsl:when test="sizes/size/price">
													<iaixsl:for-each select="sizes/size[price/@omnibus_price_net]">
														<iaixsl:sort select="price/@omnibus_price_net" data-type="number"/>
														<iaixsl:if test="position() = 1"><iaixsl:value-of select="price/@omnibus_price_net_formatted"/></iaixsl:if>
													</iaixsl:for-each>
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="price/@omnibus_price_net_formatted"/>
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:variable>

											<!-- Cena Omnibusa  -->
											<iaixsl:variable name="var_omnibus"><iaixsl:if test="$var_omnibus_enabled = 'true'">
												<iaixsl:choose>
													<!-- Czy ceny są różne, jeżeli tak to nie ma omnibusa -->
													<iaixsl:when test="$var_size_min_net_formatted != $var_size_max_net_formatted"></iaixsl:when>
													<iaixsl:when test="$var_omnibus_min != ''"><iaixsl:value-of select="$var_omnibus_min" /></iaixsl:when>
												</iaixsl:choose>
											</iaixsl:if></iaixsl:variable>

											<!-- Zmienna przechowująca informację czy ma być wyświetlona skrócona wersja Omnibusa -->
											<iaixsl:variable name="var_omnibus_short"><iaixsl:if test="$var_omnibus_enabled = 'true' and $var_maxprice_net_formatted = $var_omnibus"><![CDATA[true]]></iaixsl:if></iaixsl:variable>
											<!-- OMNIBUS-END -->

											<div class="product__prices --omnibus-new">
												<iaixsl:if test="$var_omnibus != ''"><iaixsl:attribute name="class" ><![CDATA[product__prices --omnibus-new --omnibus]]><iaixsl:if test="$var_omnibus_short = 'true'"><![CDATA[ --omnibus-short]]></iaixsl:if></iaixsl:attribute></iaixsl:if>

												<iaixsl:choose>
													<!-- Zakres ceny od - do -->
													<iaixsl:when test="$var_size_min_net_formatted != $var_size_max_net_formatted">
														<strong class="price">
															<span class="price__range --min"><iaixsl:value-of select="$var_size_min_net_formatted"/></span><iaixsl:text><![CDATA[ - ]]></iaixsl:text><span class="price__range --max"><iaixsl:value-of select="$var_size_max_net_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_net_prices"/></span><span class="price_sellby"><span class="price_sellby__sep"><iaixsl:text><![CDATA[/]]></iaixsl:text></span><span class="price_sellby__sellby" data-sellby="{$var_sellby}"><iaixsl:value-of select="$var_sellby"/></span><span class="price_sellby__unit"><iaixsl:value-of select="$var_unit"/></span></span>
														</strong>
														<iaixsl:if test="$var_points_net != ''">
															<span class="price --points">
																<iaixsl:value-of select="$var_points_net"/><span class="currency"> <iai:variable vid="pkt"/>.</span>
															</span>
														</iaixsl:if>
													</iaixsl:when>

													<!-- Cena na telefon -->
													<iaixsl:when test="(($var_net_value = 0) and $var_points_net = '') or ($var_net_value = 0 and $var_b2b and not($var_b2b = '') and not(/shop/basket/@wholesaler = 'true'))">
														<iaixsl:choose>
															<iaixsl:when test="$var_b2b and not($var_b2b = '')">
																<a class="price --phone" href="/signin.php">
																	<iaixsl:attribute name="title"><iaixsl:value-of select="$var_b2b"/></iaixsl:attribute>
																	<iaixsl:value-of select="$var_b2b"/>
																</a>
															</iaixsl:when>
															<iaixsl:otherwise>
																<a class="price --phone" href="/contact.php">
																	<iaixsl:attribute name="title"><iai:variable vid="Kliknij, by przejść do formularza kontaktu"/></iaixsl:attribute>
																	<iai:variable vid="Cena na telefon"/>
																</a>
															</iaixsl:otherwise>
														</iaixsl:choose>
													</iaixsl:when>

													<!-- Domyślna cena -->
													<iaixsl:otherwise>
														<strong class="price">
															<iaixsl:value-of select="$var_price_net_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices"/></span><span class="price_sellby"><span class="price_sellby__sep"><iaixsl:text><![CDATA[/]]></iaixsl:text></span><span class="price_sellby__sellby" data-sellby="{$var_sellby}"><iaixsl:value-of select="$var_sellby"/></span><span class="price_sellby__unit"><iaixsl:value-of select="$var_unit"/></span></span>
														</strong>
														<iaixsl:if test="$var_points_net != ''">
															<span class="price --points">
																<iaixsl:value-of select="$var_points_net"/><span class="currency"> <iai:variable vid="pkt"/>.</span>
															</span>
														</iaixsl:if>
														<!-- OMNIBUS -->
														<iaixsl:if test="$var_omnibus != ''">
															<span class="omnibus_price"><span class="omnibus_price__text"><iai:variable vid="Najniższa cena produktu w okresie 30 dni przed wprowadzeniem obniżki"/> </span><del class="omnibus_price__value"><iaixsl:value-of select="$var_omnibus" /></del><span class="price_sellby"><span class="price_sellby__sep"><iaixsl:text><![CDATA[/]]></iaixsl:text></span><span class="price_sellby__sellby" data-sellby="{$var_sellby}"><iaixsl:value-of select="$var_sellby"/></span><span class="price_sellby__unit"><iaixsl:value-of select="$var_unit"/></span></span></span>
														</iaixsl:if>
														<!-- OMNIBUS-END -->
														<iaixsl:if test="$var_maxprice_net_formatted != ''">
															<span class="price --max">
																<span class="omnibus_label"><iai:variable vid="Cena regularna"/> </span>
																<del>
																	<iaixsl:value-of select="$var_maxprice_net_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices"/></span>
																</del><span class="price_sellby"><span class="price_sellby__sep"><iaixsl:text><![CDATA[/]]></iaixsl:text></span><span class="price_sellby__sellby" data-sellby="{$var_sellby}"><iaixsl:value-of select="$var_sellby"/></span><span class="price_sellby__unit"><iaixsl:value-of select="$var_unit"/></span></span>
															</span>
														</iaixsl:if>
													</iaixsl:otherwise>
												</iaixsl:choose>
                        <iaixsl:if test="price/@unit_converted_price_net_formatted or product/price/@unit_converted_price_net_formatted ">
                          <small class="price --convert"><![CDATA[(]]><iaixsl:value-of select="price/@unit_converted_price_net_formatted"/><iaixsl:value-of select="product/price/@unit_converted_price_net_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices"/></span><![CDATA[)]]></small>
                        </iaixsl:if>
											</div>
										</iaixsl:otherwise>
									</iaixsl:choose>

									<!-- OPINIE -->
									<iaixsl:if test="client/@client or @note or content">
										<div class="product__opinion">

											<!-- Label (nie)potwierdzonej opinii -->
											<div class="opinions_element_confirmed">
												<iaixsl:attribute name="class" ><![CDATA[opinions_element_confirmed --]]><iaixsl:value-of select="@confirmedByPurchase" /></iaixsl:attribute>
												<strong class="opinions_element_confirmed_text"><iaixsl:choose><iaixsl:when test="@confirmedByPurchase = 'true'"><iai:variable vid="Opinia potwierdzona zakupem"/></iaixsl:when><iaixsl:otherwise><iai:variable vid="Opinia niepotwierdzona zakupem"/></iaixsl:otherwise></iaixsl:choose></strong>
											</div>

											<!-- Dane klienta -->
											<iaixsl:if test="client/@client">
												<div class="product__opinion_client"><iaixsl:value-of disable-output-escaping="yes" select="client/@client"/></div>
											</iaixsl:if>

											<!-- Gwiazdki -->
											<iaixsl:if test="@note">
												<div class="note">
													<span>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 0.5"><iaixsl:attribute name="class"><![CDATA[icon-star --active]]></iaixsl:attribute></iaixsl:if>
														</i>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 1.5"><iaixsl:attribute name="class"><![CDATA[icon-star --active]]></iaixsl:attribute></iaixsl:if>
														</i>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 2.5"><iaixsl:attribute name="class"><![CDATA[icon-star --active]]></iaixsl:attribute></iaixsl:if>
														</i>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 3.5"><iaixsl:attribute name="class"><![CDATA[icon-star --active]]></iaixsl:attribute></iaixsl:if>
														</i>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 4.5"><iaixsl:attribute name="class"><![CDATA[icon-star --active]]></iaixsl:attribute></iaixsl:if>
														</i>
													</span>
													<small>
														<iai:variable vid="Ocena"/>: <iaixsl:value-of disable-output-escaping="yes" select="@note"/>/5
													</small>
												</div>
											</iaixsl:if>

											<!-- Treść opinii -->
											<iaixsl:if test="content">
												<div class="product__opinion_content"><iaixsl:value-of disable-output-escaping="yes" select="content"/></div>
											</iaixsl:if>
										</div>
									</iaixsl:if>
								</div>
							</iaixsl:for-each>
						</div>
					</iaixsl:when>
					<iaixsl:otherwise>
						<div class="hotspot mb-5 skeleton">
							<span class="headline"/>
							<div class="products d-flex flex-wrap">
								<div class="product col-6 col-sm-3 col-xl-2 py-3">
									<span class="product__icon d-flex justify-content-center align-items-center"/>
									<span class="product__name"/>
									<div class="product__prices"/>
								</div>
								<div class="product col-6 col-sm-3 col-xl-2 py-3">
									<span class="product__icon d-flex justify-content-center align-items-center"/>
									<span class="product__name"/>
									<div class="product__prices"/>
								</div>
								<div class="product col-6 col-sm-3 col-xl-2 py-3">
									<span class="product__icon d-flex justify-content-center align-items-center"/>
									<span class="product__name"/>
									<div class="product__prices"/>
								</div>
								<div class="product col-6 col-sm-3 col-xl-2 py-3">
									<span class="product__icon d-flex justify-content-center align-items-center"/>
									<span class="product__name"/>
									<div class="product__prices"/>
								</div>
							</div>
						</div>
					</iaixsl:otherwise>
				</iaixsl:choose>
			</section>
		</iaixsl:if>
		<!--BANNER W KAFELKU PRODUKTOWYM-->
		<iaixsl:if test="/shop/navigation3/item[2][@name and @gfx_inactive_desktop and @gfx_inactive_mobile and @gfx_inactive_tablet]">
      <template data-id="main_hotspot_zone2">
        <div class="product --banner col-6 col-sm-3 col-xl-2 py-3">
            <a href="#" class="product__banner">
              <iaixsl:if test="/shop/navigation3/item[2]/@link">
                <iaixsl:attribute name="href"><![CDATA[/search.php?node=]]><iaixsl:value-of select="/shop/navigation3/item[2]/@link"/></iaixsl:attribute>
              </iaixsl:if>
              <picture>
                <source media="(min-width: 979px)">
                  <iaixsl:attribute name="srcset"><iaixsl:value-of select="/shop/navigation3/item[2]/@gfx_inactive_desktop"/></iaixsl:attribute>
                </source>
                <source media="(min-width: 757px)">
                  <iaixsl:attribute name="srcset"><iaixsl:value-of select="/shop/navigation3/item[2]/@gfx_inactive_tablet"/></iaixsl:attribute>
                </source>
                <img>
                  <iaixsl:attribute name="src"><iaixsl:value-of select="/shop/navigation3/item[2]/@gfx_inactive_mobile"/></iaixsl:attribute>
                </img>
              </picture>
            </a>
        </div>
      </template>
    </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/comments/@id"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/@hotspot_ajax"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/sizes/size/availability/@id"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/category/@id"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/opinion"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/@version_name"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/firm/@name"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/traits/@id"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/price/@price_formatted"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/price/@detalprice_net_formatted"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/price/@price_formatted"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/price/@price_net_formatted"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/price/@value=0"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/price/@maxprice_net_formatted"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/product/description"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/@iairs_ajax"> </iaixsl:if>
		<iaixsl:if test="/shop/page/hotspot/products_zone2/@cache_html"> </iaixsl:if>
	<iaiajaxend/>
<cdata-end/></iai:componentsdata></iai:component>
<!--DODAWANIE DO KOSZYKA-->
<div class="product__buy_section">
  <iaixsl:if test="sizes/availability/@status = 'disable'">
    <iaixsl:attribute name="class"><![CDATA[product__buy_section --disabled]]></iaixsl:attribute>	
  </iaixsl:if>
  <iaixsl:if test="count(sizes/size) &gt; 1 or (not(sizes/size/@type = 'uniw') and not(sizes/size/@type = 'onesize'))">
    <iaixsl:attribute name="class"><![CDATA[product__buy_section --sizes]]></iaixsl:attribute>	
  </iaixsl:if>
  <iaixsl:choose>
    <iaixsl:when test="@product_type = 'product_item' and sizes/size/@amount">
      <div class="product__buy_number_wrapper">
        <button class="product__buy_number_down" type="button"><iaixsl:text><![CDATA[-]]></iaixsl:text></button>
        <input class="product__buy_number" type="number" name="number">
          <iaixsl:if test="order_quantity_range/min_quantity_per_order">
            <iaixsl:attribute name="data-minimum-quantity" ><iaixsl:value-of select="order_quantity_range/min_quantity_per_order/text()" /></iaixsl:attribute>
          </iaixsl:if>
          <iaixsl:attribute name="data-sellby"><iaixsl:value-of select="sizes/@unit_sellby"/></iaixsl:attribute>
          <iaixsl:attribute name="step"><iaixsl:value-of select="sizes/@unit_sellby"/></iaixsl:attribute>
          <iaixsl:attribute name="value"><iaixsl:value-of select="sizes/@unit_sellby"/></iaixsl:attribute>		
          <iaixsl:attribute name="data-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
          <iaixsl:attribute name="data-amount"><iaixsl:value-of select="sizes/size/@amount"/></iaixsl:attribute>
          <iaixsl:attribute name="data-quantity"><iaixsl:value-of select="sizes/@unit_sellby"/></iaixsl:attribute>
          <iaixsl:attribute name="data-size"><iaixsl:value-of select="sizes/size/@type"/></iaixsl:attribute>
          <iaixsl:attribute name="data-unit"><iaixsl:value-of select="sizes/@unit"/></iaixsl:attribute>
          <iaixsl:attribute name="data-unit_precision"><iaixsl:value-of select="sizes/@unit_precision"/></iaixsl:attribute>
        </input>
        <button class="product__buy_number_up" type="button"><iaixsl:text><![CDATA[+]]></iaixsl:text></button>	
      </div>
      <a href="#add_to_basket" class="product__buy_button btn --solid --small">
        <iaixsl:attribute name="data-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
        <iai:variable vid="Dodaj do koszyka"/>
      </a>
    </iaixsl:when>
    <iaixsl:otherwise>	
      <iaixsl:attribute name="class"><![CDATA[product__buy_section --link]]></iaixsl:attribute>
      <a class="product__buy_link btn --solid --small">
        <iaixsl:attribute name="data-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>   
        <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
        <iai:variable vid="Zobacz"/>
      </a>
    </iaixsl:otherwise>
  </iaixsl:choose>
</div>

<!-- DETALE -->
<div class="product__details">
  <!-- ROZMIARY -->
  <iaixsl:if test="count(sizes/size) &gt; 1 or (not(sizes/size/@type = 'uniw') and not(sizes/size/@type = 'onesize'))">
    <div class="product__sizes">
      <div class="product__sizes_label"><iai:variable vid="Wybierz rozmiar"/><![CDATA[:]]></div>
      <div class="product__sizes_row">
        <iaixsl:for-each select="sizes/size">
          <div class="product__size f-group --radio">
            <iaixsl:if test="not(@amount &gt; 0) and not(@amount = '-1')">
              <iaixsl:attribute name="class"><iaixsl:text><![CDATA[product__size f-group --radio --disabled]]></iaixsl:text></iaixsl:attribute>
            </iaixsl:if>
            <input type="radio" class="product__size_input f-control">
              <iaixsl:attribute name="name"><iaixsl:value-of select="$var_id"/><iaixsl:text><![CDATA[_product_size]]></iaixsl:text></iaixsl:attribute>
              <iaixsl:attribute name="id"><iaixsl:value-of select="$var_id"/><iaixsl:text><![CDATA[_]]></iaixsl:text><iaixsl:value-of select="@description"/></iaixsl:attribute>
              <iaixsl:attribute name="value"><iaixsl:value-of select="@type"/></iaixsl:attribute>
              <iaixsl:attribute name="data-amount"><iaixsl:value-of select="@amount"/></iaixsl:attribute>
              <iaixsl:if test="not(@amount &gt; 0) and not(@amount = '-1')">
                <iaixsl:attribute name="disabled"><iaixsl:text><![CDATA[disabled]]></iaixsl:text></iaixsl:attribute>
              </iaixsl:if>
            </input>
            <label class="product__size_label f-label">
              <iaixsl:attribute name="for"><iaixsl:value-of select="$var_id"/><iaixsl:text><![CDATA[_]]></iaixsl:text><iaixsl:value-of select="@description"/></iaixsl:attribute>
              <span><iaixsl:value-of select="@description"/></span>
            </label>
          </div>
        </iaixsl:for-each>
      </div>
  </div>
  </iaixsl:if>
</div>
<!-- Dodanie do listy ulubionych -->
<div class="product__favorite">
	<iaixsl:if test="@product_type = 'product_bundle' and not(@collection = 'true')"><iaixsl:attribute name="data-product-disabled">true</iaixsl:attribute></iaixsl:if>
	<iaixsl:attribute name="data-product-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
	<iaixsl:attribute name="data-product-size"><iaixsl:if test="not(count(sizes/size) > 1)"><iaixsl:value-of select="sizes/size/@type"/></iaixsl:if></iaixsl:attribute>

	<!-- Lista rozmiarów -->
	<iaixsl:if test="count(sizes/size) > 1">
		<div class="product__favorite_sizes --wrapper">
			<span class="product__favorite_sizes --headline"><iai:variable vid="Wybierz rozmiar"/></span>
			<div class="product__favorite_sizes --list">
				<iaixsl:for-each select="sizes/size">
					<a>
						<iaixsl:attribute name="class"><![CDATA[product__favorite_sizes --item]]><iaixsl:if test="not(@amount &gt; 0 or @amount = '-1')"><![CDATA[ --disabled]]></iaixsl:if></iaixsl:attribute>
						<iaixsl:attribute name="href"><iaixsl:value-of select="@type"/></iaixsl:attribute>
						<iaixsl:attribute name="data-type"><iaixsl:value-of select="@type"/></iaixsl:attribute>

						<span class="product__favorite_sizes --name"><iaixsl:value-of select="@description"/></span>
					</a>
				</iaixsl:for-each>
			</div>
		</div>
	</iaixsl:if>


	<!-- Link -->
	<a class="product__favorite_link" href="#addToFavoriteList">
		<iaixsl:attribute name="title"><iai:variable vid="Dodaj do listy ulubionych"/></iaixsl:attribute>

		<svg width="20" height="20" viewBox="0 0 20 20" fill="" xmlns="http://www.w3.org/2000/svg">
			<path d="M17.4215 4.45277C16.5724 3.60578 15.4225 3.12948 14.2231 3.12802C13.0238 3.12655 11.8727 3.60005 11.0215 4.44496L9.99965 5.39418L8.97699 4.44184C8.12602 3.59325 6.9728 3.11746 5.77103 3.11915C4.56926 3.12083 3.41738 3.59985 2.56879 4.45082C1.7202 5.30179 1.24441 6.45501 1.2461 7.65678C1.24778 8.85855 1.7268 10.0104 2.57777 10.859L9.55824 17.9418C9.6164 18.0009 9.68572 18.0478 9.76217 18.0798C9.83862 18.1118 9.92067 18.1283 10.0036 18.1283C10.0864 18.1283 10.1685 18.1118 10.2449 18.0798C10.3214 18.0478 10.3907 18.0009 10.4489 17.9418L17.4215 10.859C18.2707 10.0093 18.7477 8.85719 18.7477 7.6559C18.7477 6.4546 18.2707 5.30247 17.4215 4.45277ZM16.5348 9.9809L9.99965 16.609L3.46059 9.97465C2.8452 9.35926 2.49948 8.52462 2.49948 7.65434C2.49948 6.78405 2.8452 5.94941 3.46059 5.33402C4.07597 4.71864 4.91061 4.37292 5.7809 4.37292C6.65118 4.37292 7.48582 4.71864 8.10121 5.33402L8.11684 5.34965L9.57387 6.70512C9.68952 6.81275 9.84165 6.87259 9.99965 6.87259C10.1576 6.87259 10.3098 6.81275 10.4254 6.70512L11.8825 5.34965L11.8981 5.33402C12.5139 4.71905 13.3488 4.37389 14.219 4.37448C15.0893 4.37507 15.9237 4.72135 16.5387 5.33715C17.1537 5.95295 17.4988 6.78782 17.4983 7.65811C17.4977 8.52839 17.1514 9.3628 16.5356 9.97777L16.5348 9.9809Z"/>
		</svg>
	</a>
</div>

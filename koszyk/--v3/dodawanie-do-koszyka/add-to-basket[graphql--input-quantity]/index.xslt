<!--DODAWANIE DO KOSZYKA-->
<div class="product_buy_section">
	<iaixsl:if test="sizes/availability/@status = 'disable'">
		<iaixsl:attribute name="class"><![CDATA[product_buy_section --disabled]]></iaixsl:attribute>	
	</iaixsl:if>
	<iaixsl:choose>
		<iaixsl:when test="@product_type = 'product_item' and sizes/size/@amount">
			<div class="product_buy__number_wrapper">
				<button class="product_buy__number_down" type="button">
					<svg width="15" height="2" viewBox="0 0 15 2" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M0.700635 0C0.513416 0.00393139 0.335247 0.0779382 0.204289 0.206229C0.0733321 0.33452 0 0.506899 0 0.686374C0 0.86585 0.0733321 1.03815 0.204289 1.16644C0.335247 1.29473 0.513416 1.36882 0.700635 1.37275H13.5885C13.7758 1.36882 13.9539 1.29473 14.0849 1.16644C14.2158 1.03815 14.2892 0.86585 14.2892 0.686374C14.2892 0.506899 14.2158 0.33452 14.0849 0.206229C13.9539 0.0779382 13.7758 0.00393139 13.5885 0H0.700635Z" fill="black"/>
					</svg>
				</button>
				<input class="product_buy__number" type="number" name="number">
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
				<button class="product_buy__number_up" type="button">
					<svg width="16" height="15" viewBox="0 0 16 15" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M14.6811 8.24669H8.23572V14.4277C8.23572 14.7438 7.96854 15 7.63893 15C7.30932 15 7.04214 14.7438 7.04214 14.4277V8.24669H0.596791C0.267183 8.24669 0 7.99046 0 7.67437C0 7.35828 0.267183 7.10206 0.596791 7.10206H7.04214V0.921057C7.04214 0.604967 7.30932 0.348742 7.63893 0.348742C7.96854 0.348742 8.23572 0.604967 8.23572 0.921057V7.10206H14.6811C15.0107 7.10206 15.2779 7.35828 15.2779 7.67437C15.2779 7.99046 15.0107 8.24669 14.6811 8.24669Z" fill="black"/>
					</svg>
				</button>	
			</div>
			<a href="#add_to_basket" class="product_buy__button btn --solid --small">
				<iaixsl:attribute name="data-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
				<i class="icon-basket-buy">
                    <svg width="19" height="16" viewBox="0 0 19 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M8.38672 15.8203C9.30899 15.8203 10.0566 15.112 10.0566 14.2382C10.0566 13.3645 9.30899 12.6562 8.38672 12.6562C7.46445 12.6562 6.7168 13.3645 6.7168 14.2382C6.7168 15.112 7.46445 15.8203 8.38672 15.8203Z" fill="white"/>
                        <path d="M13.9907 15.8203C14.913 15.8203 15.6606 15.112 15.6606 14.2382C15.6606 13.3645 14.913 12.6562 13.9907 12.6562C13.0685 12.6562 12.3208 13.3645 12.3208 14.2382C12.3208 15.112 13.0685 15.8203 13.9907 15.8203Z" fill="white"/>
                        <path d="M0.556637 1.05472H2.87793L5.5653 9.96723L5.35452 10.3666C4.79951 11.4171 5.60519 12.6562 6.84831 12.6562H16.2167C16.5244 12.6562 16.7733 12.4203 16.7733 12.1289C16.7733 11.8374 16.5244 11.6015 16.2167 11.6015H6.84831C6.43495 11.6015 6.1648 11.1892 6.35038 10.8383L6.50423 10.5468H16.2167C16.4651 10.5468 16.6836 10.3908 16.7522 10.1642L18.9787 2.78144C19.0265 2.62232 18.9928 2.45133 18.8879 2.319C18.7825 2.18716 18.6178 2.1094 18.4433 2.1094H4.35376L3.83301 0.382638C3.7645 0.156058 3.546 0 3.29756 0H0.556637C0.248965 0 0 0.235862 0 0.527341C0 0.818819 0.248965 1.05472 0.556637 1.05472Z" fill="white"/>
                    </svg>
                </i>
				<iai:variable vid="Dodaj do koszyka"/>
			</a>
		</iaixsl:when>
		<iaixsl:otherwise>	
			<iaixsl:attribute name="class"><![CDATA[product_buy_section --link]]></iaixsl:attribute>
			<a class="product_buy__button btn --solid --small">
				<iaixsl:attribute name="data-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>   
		<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
		<iai:variable vid="Zobacz"/>
			</a>
		</iaixsl:otherwise>
	</iaixsl:choose>
</div>
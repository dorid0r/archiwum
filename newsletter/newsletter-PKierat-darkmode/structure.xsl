<?xml version="1.0" encoding="UTF-8"?><iai:component><iai:componentsdata><cdata-start/>
	<div id="menu_newsletter" class="newsletter --mail_only --dark">
		<form action="/settings.php" method="post" class="newsletter__form">
			<iaixsl:if test="/shop/action/settings/@url">
				<iaixsl:attribute name="action"><iaixsl:value-of select="/shop/action/settings/@url"/></iaixsl:attribute>
			</iaixsl:if>

			<div class="newsletter__head">
				<iaixsl:choose>
					<iaixsl:when test="/shop/client_data/@mailing = '1'">
						<label class="big_label"><iai:variable vid="Newsletter - zapisano"/></label>   
					</iaixsl:when>
					<iaixsl:otherwise>
						<label class="big_label"><iai:variable vid="Newsletter"/></label>
					</iaixsl:otherwise>
				</iaixsl:choose>
				<span><iai:variable vid="Zapisz się swój i otrzymuj informacje o nowościach i promocjach!"/></span>
			</div>  

			<div class="f-group newsletter__input --mail">
					<input class="f-control validate" id="mailing_email" name="mailing_email" type="text" required="required" data-validate="email">                            
						<iaixsl:if test="/shop/client_data/@mailing = '1'">
							<iaixsl:attribute name="value"><iaixsl:value-of select="/shop/client_data/@email"/></iaixsl:attribute>
						</iaixsl:if>
					</input>
					<label for="mailing_email" class="f-label">
						<iai:variable vid="Podaj swój adres e-mail"/></label> 
					<span class="f-control-feedback"/>
			</div>
			
				<div class="newsletter__btn">
				<iaixsl:choose>
					<iaixsl:when test="/shop/client_data/@mailing = '1'">
						<button name="mailing_action" value="Wypisz się" type="submit" class="btn --solid --secondary --medium remove_newsletter">
							<iaixsl:attribute name="title"><iai:variable vid="Wypisz się z newslettera"/></iaixsl:attribute>
							<iai:variable vid="Wypisz się"/></button>
					</iaixsl:when> 
					<iaixsl:otherwise>
						<button name="mailing_action" value="add" type="submit" class="btn --solid --secondary --medium add_newsletter">
							<iaixsl:attribute name="title"><iai:variable vid="Zapisz się do newslettera"/></iaixsl:attribute>
							<iai:variable vid="Zapisz się"/></button>
					</iaixsl:otherwise>
				</iaixsl:choose>                        
			</div>

			<div class="f-group --checkbox newsletter__checkbox f-feedback">
				<input class="f-control validate" id="mailing_policy" name="mailing_policy" required="required" type="checkbox"/>
				<label class="f-label mailing_policy__label" for="mailing_policy">
					<span><iai:variable vid="Wyrażam zgodę na przetwarzanie moich danych osobowych (adres e-mail) na potrzeby wysyłki newslettera z informacją handlową (marketing). Więcej w"/>
						<iaixsl:choose>
							<iaixsl:when test="/shop/action/private_policy/@url">
								<a target="_blank">
									<iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/private_policy/@url"/></iaixsl:attribute>
									<iai:variable vid="polityce prywatności"/>.
								</a>
							</iaixsl:when>
							<iaixsl:otherwise><iai:variable vid="polityce prywatności"/>.</iaixsl:otherwise>
						</iaixsl:choose>
					</span>
				</label>
			</div>
		</form>
	</div>
<cdata-end/></iai:componentsdata></iai:component>

<#macro show social>
  <#assign useGrid = (social.providers?size gt 3)>
  <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
      <ul class="${properties.kcFormSocialAccountListClass!} <#if useGrid>${properties.kcFormSocialAccountListGridClass!}</#if>">
          <#list social.providers as p>
              <li class="<#if useGrid>${properties.kcFormSocialAccountGridItem!}<#else>${properties.kcFormSocialAccountListItemClass!}</#if>">
                  <a data-once-link data-disabled-class="${properties.kcFormSocialAccountListButtonDisabledClass!}" id="social-${p.alias}"
                          class="${properties.kcFormSocialAccountListButtonClass!} <#if useGrid>${properties.kcFormSocialAccountGridItem!}</#if>"
                          type="button" href="${p.loginUrl}">
                      <#if p.iconClasses?has_content>
                          <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                          <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                      <#else>
                          <span class="${properties.kcFormSocialAccountNameClass!}"><#if useGrid>${p.displayName!}<#else>${msg("signInWithProvider", p.displayName!)}</#if></span>
                      </#if>
                  </a>
              </li>
          </#list>
      </ul>
  </div>
</#macro>
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 300;
  src: local('Roboto Light'), local('Roboto-Light'), url(https://fonts.gstatic.com/s/roboto/v16/Hgo13k-tfSpn0qi1SFdUfVtXRa8TVwTICgirnJhmVJw.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2212, U+2215;
}

/* === TEMPLATE OVERRIDE ============================================= */

/* --- Home --- */

.comm-page-home .slds-col--padded.comm-content-header.comm-layout-column {
    padding: 0;
}

.comm-page-home .comm-content-header + div, .comm-content-footer {
    max-width: 1440px;
    margin: auto;
}

.comm-page-home .siteforcePrmBody .cCenterPanel {
    max-width: unset;
    width: 100%;
    margin: 0;
    padding: 0;
}

.comm-page-home .siteforcePrmBody .cCenterPanel>*>.slds-grid>.slds-medium-size--8-of-12.slds-large-size--8-of-12.comm-layout-column {
    padding: 30px;
    border-right: solid 1px #e9ecf0;
}

.comm-page-home .slds-medium-size--4-of-12.slds-large-size--4-of-12 .slds-col--padded.comm-layout-column {
    padding: 30px 30px 0;
}

.comm-page-home .forceCommunityDashboard .desktopDashboardsDashboard.dashboardTopLevelContainer.standalone {
    width: calc(100% + 32px);
    height: calc(100% + 16px);
    margin: -16px 0 0 -16px;
}

/* === STANDARD COMPONENT OVERRIDE ============================================= */

/* --- Record List --- */

.sfaTaskList, .forceListViewManager {
    border: solid 1px #dfe3eb;
    border-radius: 4px;
}

.slds-table_header-fixed_container, .slds-table--header-fixed_container {
    border-radius: 4px;
}

.slds-page-header.slds-page-header_joined.slds-page-header--object-home {
    background-color: #f0f4fa;
    padding: .65rem;
    border: none;
}

/* --- Tabs --- */

.forceCommunityTabset .uiTabBar .uiTabItem .tabHeader {
    padding: 14px 0;
}

.uiTabset--base .tabs__item {
    font-size: 1rem;
}

.uiTabset--default .tabs__item > a {
	color: #16325c !important;
}

.uiTabset--default .tabs__item.active > a, .uiTabset--default .tabs__item>a:hover, .uiTabset--default .tabs__item>a:focus {
    border-color: #177ed6 !important;
    color: #4d9ce0 !important;
}

.uiTabset--default .tabs__item>a:focus {
    box-shadow: #177ed6 0 -1px 0 inset !important;
}

.uiTabBar .tabs__nav {
	margin-bottom: 33px;
}

/* === TEXT ============================================= */

.pink {
    color: #cb1488;
}

.thin {
    font-weight: 300;
}

.slds-text-body_large {
    font-size: 1.142857142857143em;
}

[class*=slds-text-heading_] {
    font-weight: bold;
}

.slds-text-title_xx-large {
    color: #354378;
    font-size: 54px;
}

/* === BUTTONS ============================================= */

.slds-button_neutral, .slds-button--neutral {
    border-radius: 4px;
    font-size: 13px;
    background-color: #ffffff;
    border: solid 1px #d8dde6;
    height: 33px;
    line-height: inherit;
}

.slds-button_brand {
    border-radius: 3px;
    min-width: 263px;
    font-size: 16px;
    height: 44px;
}

.slds-button_brand, .slds-button--brand,
.slds-button--neutral.uiButton--brand {
    background-color: #e8007f;
    border: solid 1px #e8007f;
}

/* === CONTROLS ============================================= */

.form-element__label:not(.uiLabel-hidden) {
    display: inline-block;
    color: rgb(84, 105, 141);
    font-size: .75rem;
    line-height: 1.5;
    margin-right: .75rem;
    margin-bottom: .125rem;
}

.slds-form-element__static {
	color: #1b436f;
    font-size: 1.142857142857143em;
    font-weight: 300;
}

textarea, .uiInput--textarea .textarea, .uiInput--textarea.textarea {
    border-radius: 4px;
    border: solid 1px #a8b7c7;
}

/* --- Custom Radio --- */

.radio-special {
    display: flex;
}

.radio-special .slds-form-element, .radio-special .uiInputRadio {
    width: 100%;
    margin-right: 5px;
}

.radio-special .slds-form-element:last-child, .radio-special .uiInputRadio:last-child {
	margin-right: 0;
}

.radio-special label {
    display: inline-flex;
    width: 100%;
    height: 100%;
    padding: 9px;
    border-radius: 4px;
    background-color: #ffffff;
    border: solid 2px #c1c6d0;
    justify-content: center;
    align-items: center;
    text-align: center;
}

.radio-special .form-element__label {
    margin-bottom: 0;
}

.radio-special input:checked + label {
    border-color: #1589ee;
}

.radio-special .slds-form-element__control, .radio-special .slds-radio {
    height: 100%;
}

.radio-special input, 
.radio-special .slds-radio .slds-radio_faux, .radio-special .slds-radio .slds-radio--faux {
	display: none;
}

.radio-special label span {
    line-height: 1;
    margin: 0;
    display: inline-block;
}

/* === MISC ============================================= */

hr {
    margin: 20px 0;
    border-top: solid 2px #c1c6d0;
}

/* === ACCORDIONS ============================================= */

.slds-accordion__section {
    border-radius: 4px;
    overflow: hidden;
    padding: 0;
    margin-bottom: 10px;
}

.slds-accordion__summary {
    background-color: #1589ee;
    color: #ffffff;
	padding: 0.75em;
}

.slds-accordion__summary .count {
    height: 27px;
    width: 27px;
    background: #ffffff;
    color: #1589ee;
    display: inline-flex;
    justify-content: center;
    align-content: center;
    border-radius: 50%;
    font-size: 16px;
    line-height: 1.75;
    margin-right: 10px;
}

.slds-accordion__summary-heading {
	font-size: 18px;
    font-weight: normal;
}

.slds-accordion__summary .slds-button_icon-bare, .slds-accordion__summary .slds-button--icon-bare {
	color: inherit;
	height: auto;
}

.slds-accordion__content {
    display: none;
	border: solid 0.5px #c1c6d0;
	border-top: none;
    border-bottom-left-radius: inherit;
    border-bottom-right-radius: inherit;
}

.slds-is-open .slds-accordion__summary {
    margin-bottom: 0;
}

.slds-is-open .slds-accordion__content {
    display: block;
}

/*Header start*/
.navigationMenuWrapper{
background-color:#f4f4f4;
}
body .forceCommunityNavigationMenu .menuItemLink,body .forceCommunityNavigationMenu .menuItemLink.triggerLink{
  color: #1b436f;
  text-decoration: none;
  border-bottom: 3px solid transparent;
}
body .siteforceNapiliBody .cHeaderPanel{
    height: 125px;
    background-color:#fff;
 
}
body .siteforceNapiliBody .selfServiceSearchWrapper .no-assigned-image {
    height: 0px;
}
body .selfServiceProfileMenuTrigger a{
      color: #354378;  
        text-shadow: 0 0 0px #354378;
}
body .forceCommunityNavigationMenu .menuItemLink:hover,body .forceCommunityNavigationMenu .menuItemLink:focus,body .forceCommunityNavigationMenu .menuItemLink.triggerLink:hover,body .forceCommunityNavigationMenu .menuItemLink.triggerLink:focus,body .forceCommunityNavigationMenu .menuItem.current .menuItemLink,body .forceCommunityNavigationMenu .menuItem.current .menuItemLink.triggerLink {
    color: #006db2;
    border-bottom: 3px solid #cb1488;
    background-color: #f4f4f4;
}
body .slds-global-header__button_icon,body .slds-global-header__button--icon, body .slds-global-header__button_icon:hover:not(:disabled), .slds-global-header__button_icon:focus, .slds-global-header__button--icon:hover:not(:disabled), .slds-global-header__button--icon:focus {
    margin: 0 .25rem;
    color: #1b436f;
}
body .forceCommunityNavigationMenu .homeButton.menuItemLink:hover, .forceCommunityNavigationMenu .homeButton.menuItemLink:focus {
    color: #1b436f;
    background-color: transparent;
    border: 0;
}
body .siteforcePrmBody .cHeader .forceCommunityNavigationMenu .menuItemLink, .siteforcePrmBody .cHeader .forceCommunityNavigationMenu .menuItemLink.triggerLink {
    padding: 7px 14px;
    color: #1b436f;
}
body .siteforcePrmBody .cHeader .forceCommunityNavigationMenu .menuItem.current .menuItemLink{
    color: #1b436f;
}
@media only screen and (min-width: 48em)
{
body .siteforceNapiliBody .cHeaderLine {
    padding:20px 0px;
}
}
/*Header end*/
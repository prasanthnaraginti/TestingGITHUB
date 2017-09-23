@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 300;
  src: local('Roboto Light'), local('Roboto-Light'), url(https://fonts.gstatic.com/s/roboto/v16/Hgo13k-tfSpn0qi1SFdUfVtXRa8TVwTICgirnJhmVJw.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2212, U+2215;
}
@font-face {
  font-family: 'Roboto';
  font-style: italic;
  font-weight: 300;
  src: local('Roboto Light Italic'), local('Roboto-LightItalic'), url(https://fonts.gstatic.com/s/roboto/v16/7m8l7TlFO-S3VkhHuR0at44P5ICox8Kq3LLUNMylGO4.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2212, U+2215;
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  src: local('Roboto Medium'), local('Roboto-Medium'), url(https://fonts.gstatic.com/s/roboto/v16/RxZJdnzeo3R5zSexge8UUVtXRa8TVwTICgirnJhmVJw.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2212, U+2215;
}
@font-face {
  font-family: 'RobotoSlab';
  font-style: normal;
  font-weight: 300;
  src: local('Roboto Slab Light'), local('RobotoSlab-Light'), url(https://fonts.gstatic.com/s/robotoslab/v6/dazS1PrQQuCxC3iOAJFEJUo2lTMeWA_kmIyWrkNCwPc.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2212, U+2215;
}

/* === TEMPLATE OVERRIDE ============================================= */

/* --- Home --- */

.comm-page-home .siteforceNapiliBody .cCenterPanel {
	max-width: none;
}

.comm-page-home .siteforceNapiliBody .cCenterPanel .slds-col--padded {
	padding: 0;
}

.comm-page-home .slds-col--padded .ui-widget {
	margin-top: 0;
}

/* === TEXT ============================================= */

body [class*=slds-text-heading] {
    font-weight: 500;
}

.slds-text-body_x-small {
    font-size: 0.75rem;
    font-weight: 300;
    color: #1b436f;
}

.slds-text-body_x-small a {
    text-decoration: underline;
}

.slds-text-body_x-large {
	font-size: 40px;
}

.slds-text-heading_x-small {
	font-size: 18px;
}

/* --- Global messages --- */

body .uiMessage {
    font-size: 20px;
    line-height: 1.4;
    margin: 0 0 26px 0;
    padding: 0;
}
	
body .uiMessage.error {
    color: #e8007f;
    border: none;
    background: none;
}

.uiMessage.error .bLeft:before {
    content: '\00d7';
    border: 2px solid #e8007f;
    display: inline-block;
    width: 24px;
    text-align: center;
    line-height: 19px;
    height: 24px;
    border-radius: 50%;
    margin-right: 8px;
}

/* === BUTTONS ============================================= */

body .slds-button_neutral,
body .slds-button_success,
body .slds-button_brand,
body .slds-button_inverse,
body .slds-button_destructive,
body .slds-button--neutral,
body .slds-button--success,
body .slds-button--brand,
body .slds-button--inverse,
body .slds-button--destructive {
	min-height: 44px;
    border-radius: 3px;
}

body .slds-button_success, body .slds-button--success {
    min-width: 175px;
    background-color: #228d4b;
    border-color: #228d4b;
    color: #ffffff;
    float: right;
}

body .slds-button_brand, body .slds-button--brand {
	padding-left: 5em;
    padding-right: 5em;
}

body .slds-button_neutral, body .slds-button--neutral {
	border-color: #005490;
	color: #005490;
	font-weight: 500;
}

.slds-button .slds-button__icon {
	vertical-align: baseline;
}

body .slds-button[disabled], .slds-button.disabled {
    opacity: 0.4;
    cursor: not-allowed;
    pointer-events: none;
}

/* === FORMS =================================================*/

body .slds-form_horizontal .slds-form-element__label {
	font-weight: 300;
}

body .slds-form_horizontal .slds-form-element__static {
    text-align: left;
    display: flex;
    font-size: 1em;
    padding: 0 0 0 22px;
}

/* === CONTROLS ============================================= */

.slds-form-element {
    margin-bottom: 18px;
}

.slds-has-error .slds-form-element__help, .slds-form-element__help.error {
    color: #e8007f;
}

.label-large {
    font-size: 24px;
    font-weight: 500;
    display: block;
    margin-bottom: 14px;
}

body .slds-form-element__label {
    font-size: 14px;
    color: #54698d;
    margin-bottom: 5px;
    width: 100%;
}

.required:after {
    content: '*';
    display: inline-block;
    margin-left: 5px;
    font-weight: bold;
    color: #e8007f;
}

.optional {
	font-weight: 300;
	font-style: italic;
	color: #228d4b;
	float: right;
}

body .uiInput--input .input, body .uiInput--input.input {
    line-height: 42px;
    color: #3b435b;
    border: 1px solid #a8b7c7;
    border-radius: 4px;
    font-size: 1rem;
}

input::-webkit-input-placeholder {
    color: #c1c6d0;
}
input::-moz-placeholder {
    color: #c1c6d0;
}
input:-ms-input-placeholder {
    color: #c1c6d0;
}
input:-moz-placeholder {
    color: #c1c6d0;
}

.slds-form-element__help {
    margin-top: 5px;
}

body .uiInput--input.input[disabled], body .uiInput--input .input[disabled] {
    background-color: #f3f5f9;
}

/* --- Icon input fields --- */

.slds-form-element__control.icon-prefix, .slds-form-element__control.icon-postfix {
    position: relative;
}

.slds-form-element__control.icon-prefix .slds-icon_container, .slds-form-element__control.icon-postfix .slds-icon_container {
	display: block;
}

.slds-form-element__control.icon-prefix .slds-icon, .slds-form-element__control.icon-postfix .slds-icon {
    width: 18px;
    position: absolute;
    top: 6px;
    right: 12px;
    fill: #3b435b;
    z-index: 1;
}

.slds-form-element__control.icon-prefix > .slds-icon_container:first-child .slds-icon {
    left: 12px;
    right: initial; 
    fill: #0086db;
}

.slds-form-element__control.icon-prefix input, .slds-form-element__control.icon-prefix .uiInput--select.select:not([multiple]) {
    padding-left: 40px;
}

.slds-form-element__control.icon-postfix input {
    padding-right: 40px;
}

/* --- Select --- */

body .uiInput--select.select, body .uiInput--select .select, body .uiInput--select .uiPopupTrigger a {
	color: #3b435b;
    border: 1px solid #a8b7c7;
    border-radius: 4px;
}

body .uiInput--select.select:not([multiple]), .uiInput--select .select:not([multiple]), .uiInput--select .uiPopupTrigger a {
    height: 44px;
    line-height: 42px;
}

/* --- Radio --- */

.uiInput--default.uiInput--radio {
    display: inline-block;
	position: relative;
}

.uiInput--default.uiInput--radio label {
    position: relative;
    left: 2.75em;
    margin-right: 5.5625em;
	color: #54698d;
}

.uiInput--default.uiInput--radio label:before {
    content: '';
    position: absolute;
    height: 1.572em;
    width: 1.572em;
    border-radius: 50%;
    border: solid 1px #a8b7c7;
    top: -0.1em;
    left: -2.75em;
}

.uiInput--default.uiInput--radio input {
    -webkit-appearance: none;
}

.uiInput--default.uiInput--radio input:checked:before {
    content: '';
    width: 0.715em;
    height: 0.715em;
    background: #1ea4f4;
    position: absolute;
    left: 0.4464em;
    top: calc(-0.1em + 0.4464em);
    border-radius: 50%;
}

/* --- Date picker --- */

.uiInput--datetime .datePicker-openIcon {
    top: 11px;
    height: 22px;
}

.uiInput--datetime .datePicker-openIcon::before {
    color: #3b435b;
    font-size: 22px;
    line-height: 1em;
}

/* --- Custom radio --- */

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

.radio-special .uiInput--default.uiInput--radio label {
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
    left: 0;
    margin-right: 0;
    font-size: 14px;
  	font-weight: 300;
}

.radio-special .uiInput--default.uiInput--radio label:before {
	display: none;
}

.radio-special .uiInput--default.uiInput--radio input:checked + label {
	border-color: #1589ee;
}

.radio-special .uiInput--default.uiInput--radio input:checked ~ .slds-icon_container {
	display: block;
	visibility: visible;
    background-color: #0086db;
    position: absolute;
    top: -10px;
    right: -10px;
    padding: 0 4px;
    height: 24px;
    width: 24px;
    z-index: 1;	
}

.radio-special .slds-icon-action-check .slds-icon {
    width: 15px;
    height: 15px;
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

/* --- Dropzone --- */

body .dropzone {
    border: 1px dashed #a8b7c7;
    width: 100%;
    min-height: 70px;
    color: #abb9c9;
}

/* === MISC ============================================= */

body .slds-wrap {
    -webkit-align-items: stretch;
    -ms-flex-align: stretch;
    align-items: stretch;
}

body hr {
    margin: 42px 0 20px;
}

body .slds-hidden {
    display: none;
}

.full-width {
	width: 100%;
}

/* === ACCORDIONS ============================================= */

.slds-accordion {
    margin: -20px -20px 0;
}

body .slds-accordion__list-item {
	border: none;
}

body .slds-accordion__section {
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

body .slds-is-open .slds-accordion__summary {
    margin-bottom: 0;
}

.slds-is-open .slds-accordion__content {
    display: block;
}
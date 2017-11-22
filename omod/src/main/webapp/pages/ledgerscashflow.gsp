<%
    ui.decorateWith("appui", "standardEmrPage", [title: "SRs Financial Report"])
%>


<style>
#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
    text-decoration: none;
}
body {
    margin-top: 20px;
}
form input{
    margin: 0px;
    display: inline-block;
    min-width: 50px;
    padding: 2px 10px;
}
.info-header span{
    cursor: pointer;
    display: inline-block;
    float: right;
    margin-top: -2px;
    padding-right: 5px;
}
.dashboard .info-section {
    margin: 2px 5px 5px;
}
.toast-item{
    background-color: #222;
}
form input:focus, form select:focus, form textarea:focus, form ul.select:focus, .form input:focus, .form select:focus, .form textarea:focus, .form ul.select:focus{
    outline: 1px none #007fff;
    box-shadow: 0 0 1px 0px #888!important;
}
.name {
    color: #f26522;
}
@media all and (max-width: 768px) {
    .onerow {
        margin: 0 0 100px;
    }
}
form .advanced {
    background: #363463 none repeat scroll 0 0;
    border-color: #dddddd;
    border-style: solid;
    border-width: 1px;
    color: #fff;
    cursor: pointer;
    float: right;
    padding: 5px 0;
    text-align: center;
    width: 18%;
}
form .advanced i{
    font-size: 24px;
}
.add-on {
    float: right;
    left: auto;
    margin-left: -29px;
    margin-top: 5px;
    position: absolute;
    color: #f26522;
}
.ui-widget-content a {
    color: #007fff;
}
td a{
    cursor: pointer;
    text-decoration: none;
}
td a:hover{
    text-decoration: none;
}
.recent-seen{
    background: #fff799 none repeat scroll 0 0!important;
    color: #000 !important;
}
.recent-lozenge {
    border: 1px solid #f00;
    border-radius: 4px;
    color: #f00;
    display: inline-block;
    font-size: 0.7em;
    padding: 1px 2px;
    vertical-align: text-bottom;
}
table th, table td {
    white-space: nowrap;
}
.dialog-content ul li input[type="text"],
.dialog-content ul li input[type="password"],
.dialog-content ul li select,
.dialog-content ul li textarea {
    border: 1px solid #ddd;
    display: inline-block;
    height: 40px;
    margin: 1px 0;
    min-width: 20%;
    padding: 5px 0 5px 10px;
    width: 68%;
}
#modal-overlay {
    background: #000 none repeat scroll 0 0;
    opacity: 0.3 !important;
}
form label,
.form label {
    display: inline-block;
    width: 110px;
}
.dialog select option {
    font-size: 1em;
}
.dialog .dialog-content li {
    margin-bottom: 0;
}
.dialog ul {
    margin-bottom: 10px;
}
label.user-locations input{
    margin-top: 4px;
}
.select-report{
    cursor: pointer;
}
.report-container {
    margin: 10px 0px;
}
p.reportTitle{
    font-family: "OpenSansBold";
    margin: 10px 0;
    text-align: center;
}
span.underline{
    border-bottom: 1px solid #f00;
    display: inline-block;
    min-width: 100px;
}
#itemList th{
    text-align: left;
}
#itemList td{
    text-align: center;
}
#itemList td:first-child{
    text-align: left;
}
#itemList{
    font-size: 14px;
    margin-top: 2px;
}
</style>
<ul id="breadcrumbs">
    <li>
        <a href="${ui.pageLink('referenceapplication', 'home')}">
            <i class="icon-home small"></i></a>
    </li>

    <li>
    <i class="icon-chevron-right link"></i>
    <a href="financedashboard.page?view=srs">Finance</a>
</li>
    <li>
        <i class="icon-chevron-right link"></i>
        Sub-Recipient Report
    </li>
</ul>
</div>

<div class="patient-header new-patient-header" style="margin-bottom: 1px;">
    <div class="demographics">
        <h1 class="name" style="border-bottom: 1px solid #ddd;">
            <span><i class="icon-file-alt small"></i>SUB-RECIPIENT FINANCIAL REPORT - GFATM SOMALIA &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
        </h1>
    </div>
</div>



<table>
    <tr>
        <td style="font-weight: bold; font-size: 0.9em; text-align: right; width: 209px;">
            NAME OF SR:<br/>
            REPORTING PERIOD : <br/>
            SUBMISSION NUMBER :<br/>

        </td>

        <td>
            <span class="underline" style="width: 400px"><small>&nbsp; ${centre.location.name.toUpperCase()}</small></span><br/>
            <span class="underline" style="width: 400px"><small>&nbsp; ${start} to ${ended}</small></span><br/>
            <span class="underline" style="width: 400px"><small>&nbsp; N/A</small></span><br/>


        </td>
    </tr>
</table>
<small><p class="reportTitle"><br/>Section A: OPENING CASH BALANCE FOR THE PERIOD </p></small>
<table id="itemList">
    <tr>
        <th><small>Category</small></th>
        <th><small>Amount</small></th>

    </tr>
    <tr>
        <td><small>OPENING CASH BALANCE FOR THE PERIOD &nbsp;&nbsp;&nbsp;&nbsp;</small></td>
        <td><small>0.00</small></td>

    </tr>


</table>

<small><p class="reportTitle"><br/>SECTION B: CASH IN-FLOW</p></small>
<table id="itemList">
    <tr>
        <th><small>Category</small></th>
        <th><small>Amount</small></th>

    </tr>
    <tr>
        <td><small> Disbursement Received from PR during the reporting period</small></td>
        <td><small>0.00</small></td>

    </tr>
    <tr>
        <td><small> Bank Interest Earned</small></td>
        <td><small>0.00</small></td>

    </tr>
    <tr>
        <td><small> Project Income</small></td>
        <td><small>0.00</small></td>

    </tr>
    <tr>
        <td><small> Disallowed Costs Added Back to the Program</small></td>
        <td><small>0.00</small></td>

    </tr>
    <tr>
        <td><small> Other Revenues/Receipts/Loan(ICR 5% overcharged)</small></td>
        <td><small>0.00</small></td>

    </tr>
    <tr>
        <td style="font-weight: bold"><small> Total Cash In-Flow</small></td>
        <td><small>0.00</small></td>

    </tr>

</table>

<small><p class="reportTitle"><br/>SECTION C:</p></small>
<table id="itemList">
    <tr>
        <th style="margin-left: 0px;"><small>Category</small></th>
        <th><small>Amount</small></th>

    </tr>
    <tr>
        <td><small> TOTAL CASH AVAILABLE AT SR &nbsp;&nbsp;&nbsp;&nbsp;</small></td>
        <td><small>0.00</small></td>

    </tr>

</table>

<small><p class="reportTitle"><br/>SECTION D: EXPENDITUTRE PAID BY SR</p></small>

<table id="itemList">
    <tr>
        <th><small>Category</small></th>
        <th><small>Amount</small></th>


    </tr>
    <% charts.eachWithIndex { chart, idx -> %>
    <tr>
    <td><small>${chart.name}</small></td>
    <td><small>${String.format("%1\$,.2f", (Double)chart.expenditure)}</small></td>
    </tr>
    <% } %>
    <tr>
    <td style="font-weight: bold" colspan="2"><small>Other out-flow</small></td>
        </tr>
    <tr>
        <td><small>- Expenditures Pertained to Phase I</small></td>
        <td><small>0.00</small></td>
    </tr>

    <tr>
        <td><small>- Committed Cost (Phase 1): Annex</small></td>
        <td><small>0.00</small></td>
    </tr>

    <tr>
        <td><small>- New Committed Cost (Phase 1): Annex</small></td>
        <td><small>0.00</small></td>
    </tr>
    <tr>
        <td><small>- Others:</small></td>
        <td><small>0.00</small></td>

    </tr>
    <tr>
        <td style="font-weight: bold"><small>Total Expenditure Paid By SR:</small></td>
        <td><small>${String.format("%1\$,.2f", (Double)expenditureTT)}</small></td>
    </tr>

</table>

<small><p class="reportTitle"><br/>SECTION E</p></small>

<table id="itemList">
    <tr>
        <th><small>Category</small></th>
        <th><small>Amount</small></th>
    </tr>
    <tr>
        <td><small>ENDING CASH BALANCE FOR THE PERIOD</small></td>
        <td><small>0.00</small></td>
    </tr>
</table>

<small><p class="reportTitle"><br/>SECTION F</p></small>

<table id="itemList">
    <tr>
        <th><small>EXPENDITURES PAID BY PR ON BEHALF OF SR (if any)</small></th>
        <th><small>Amount</small></th>
    </tr>
    <tr>
        <td><small>Health Products and Health Equipments</small></td>
        <td><small>0.00</small></td>
    </tr>
    <tr>
        <td><small>Medicines and Pharmaceutical Products</small></td>
        <td><small></small></td>
    </tr>
    <tr>
        <td><small>Procurement and Supply Management  (CIF only)</small></td>
        <td><small>0.00</small></td>
    </tr>
    <tr>
        <td><small>Procurement and Supply Management  (Others)</small></td>
        <td><small>0.00</small></td>
    </tr>
    <tr>
        <td style="font-weight: bold"><small>TOTAL EXPENDITURES PAID BY PR ON BEHALF OF SR</small></td>
        <td><small>0.00</small></td>
    </tr>

</table>
<small><p class="reportTitle"><br/>SECTION G</p></small>

<table id = itemList>
    <tr>
        <th><small>Category</small></th>
        <th><small>Amount</small></th>
    </tr>
    <tr>
        <td><small>TOTAL EXPENDITURES FOR THE REPORTING PERIOD</small></td>
        <td><small>0.00</small></td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>
</table>
<table style="margin: 5px 0 15px 0">
    <tr>
        <td>
            <div style="font-weight:bold; margin-bottom:5px; padding-left:10px"><small>FINANCE / GRANT CONTACT PERSON:</small></div>
            <small>NAME:      .........................................................................................................................</small><br/>
            <small>TITLE:     ........................................................................................................................... </small> <br/>
            <small>SIGNATURE:  .................................................................................................................<br/></small>
            <small>DATE:  .............................................................................................................................<br/><br/></small>

        </td>
        <td>
            <div style="font-weight:bold; margin-bottom:5px; padding-left:10px"><small>AUTHORIZED / ENDORSED BY:</small></div>
            <small>NAME:      .........................................................................................................................</small><br/>
            <small>TITLE:     ........................................................................................................................... </small> <br/>
            <small>SIGNATURE:  .................................................................................................................<br/></small>
            <small>DATE  .............................................................................................................................<br/><br/></small>

        </td>
    </tr>

</table>


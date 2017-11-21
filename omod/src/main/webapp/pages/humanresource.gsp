<% 
	ui.decorateWith("appui", "standardEmrPage", [title: "Human Resource"])
	ui.includeCss("uicommons", "datatables/dataTables_jui.css")
	ui.includeJavascript("mdrtbregistration", "jq.dataTables.min.js")
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<style>
	#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
		text-decoration: none;
	}
	.name {
		color: #f26522;
	}

	.budget-box{
		border: 1px solid #d3d3d3;
		border-top: 2px solid #363463;
		height: auto;
		margin: 5px 0 0 0;
		padding-bottom: 5px;
	}
	.budget-box div{
		width: 36%;
		display: inline-block;
	}
	.budget-box label{
		display: inherit;
		padding: 2px 10px;
		margin: 10px 0 0 0;
		width: 60px;

	}
	input, form input, select, form select, ul.select, form ul.select, textarea {
		min-width: 0;
		display: inline-block;
		width: 230px;
		height: 38px;
	}
	input, select, textarea, form ul.select, .form input, .form select, .form textarea, .form ul.select {
		color: #363463;
		padding: 5px 10px;
		background-color: #FFF;
		border: 1px solid #DDD;
	}
	textarea{
		resize: none;
		height: 120px;
		margin-top: 2px;
		width: 400px;
	}
	#date-created label{
		display: inline-block;
	}
	.button.confirm{
		margin-right:0px;
	}
	.dialog-content .confirmation{
		margin-bottom: 20px;
	}
	#modal-overlay {
		background: #000 none repeat scroll 0 0;
		opacity: 0.3 !important;
	}
	#ledgerTable{
		font-size: 12px;
		margin-top: 5px;
	}
	#ledgerTable th:last-child,
	#ledgerTable td:last-child{
		text-align: right;
	}
	#ledgerTable td:first-child{
		text-align: center;
	}
	#filter {
		margin-right:3px;
	}
	#addLedger{
		padding: 13px 7px;
		margin-right: 5px;
		margin-left: 3px;
	}
	.icon-filter.small.right{
		font-size: 1.6em;
	}
	.dialog .dialog-content li {
		margin-bottom: 0;
	}
	.dialog-content ul li label{
		display: inline-block;
		width: 120px;
	}
	.dialog-content ul li input[type=text],
	.dialog-content ul li select,
	.dialog-content ul li textarea {
		border: 1px solid #ddd;
		display: inline-block;
		height: 40px;
		margin: 1px 0;
		min-width: 20%;
		padding: 5px 0 5px 10px;
		width: 70%;
	}
	.dialog-content ul li textarea{
		height: 100px;
		resize: none;
	}
	.dialog select option {
		font-size: 1em;
	}
	.dialog ul {
		margin-bottom: 20px;
	}
	#modal-overlay {
		background: #000 none repeat scroll 0 0;
		opacity: 0.3 !important;
	}
    .dialog {
        width: 500px;
    }
    .dialog .dialog-content li {
        margin-bottom: 0;
    }
    .dialog-content ul li label {
        display: inline-block;
        width: 150px;
    }
    .dialog-content ul li input[type="text"], .dialog-content ul li select, .dialog-content ul li textarea {
        border: 1px solid #ddd;
        display: inline-block;
        height: 40px;
        margin: 1px 0;
        min-width: 20%;
        padding: 5px 0 5px 10px;
        width: 64%;
    }
    .dialog select option {
        font-size: 1em;
    }
    .dialog ul {
        margin-bottom: 20px;
    }
    .button.confirm {
        margin-right: 6px;
    }



</style>

<script>
 jq(function () {
     jq('#addStaff').click(function(){
         jq('#incomeIdnt').val(1);

         addStaffDialog.show();
     });

     jq('#editStaff').click(function () {
        editStaffDialog.show();
     })


     var addStaffDialog = emr.setupConfirmationDialog({
         dialogOpts: {
             overlayClose: false,
             close: true
         },
         selector: '#addStaff-dialog',
         actions: {
             confirm: function() {
                 if (jq('#facility').val() == ''){
                     jq().toastmessage('showErrorToast', 'Invalid Facility. Kindly provide the correct value for the facility');
                     return false;
                 }

                 if (jq('#addStaffIdnt').val() == 1){
                     window.location.href = "ledgerstatement.page?facility="+jq('#incomeFacility').val()+"&yr="+jq('#incomeYear').val();
                 }
             },
             cancel: function() {
                 addStaffDialog.close();
             }
         }
     });

     var editStaffDialog = emr.setupConfirmationDialog({
         dialogOpts: {
             overlayClose: false,
             close: true
         },
         selector: '#editStaff-dialog',
         actions: {
             confirm: function() {
                 if (jq('#facility').val() == ''){
                     jq().toastmessage('showErrorToast', 'Invalid Facility. Kindly provide the correct value for the facility');
                     return false;
                 }

                 if (jq('#editStaffIdnt').val() == 1){
                     window.location.href = "ledgerstatement.page?facility="+jq('#incomeFacility').val()+"&yr="+jq('#incomeYear').val();
                 }
             },
             cancel: function() {
                 editStaffDialog.close();
             }
         }
     });

 })


</script>

<div class="example">
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
            Human Resource
        </li>
    </ul>
</div>

<div class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-group  small"></i>HUMAN RESOURCE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div id="show-icon">
		<span class="button confirm right" id="addStaff">
			<i class="icon-plus small"></i>
		</span>
		
		<select id="locations" class="right" style="width:200px;">
			<option value="-1">All</option>
			<% locations.eachWithIndex { loc, index -> %>
				<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
			<% } %>
		</select>
		
		<input id="filter" class="right" placeholder="Filter Staff" />
		<i class="icon-filter small right"></i>
		
		<div class="clear both"></div>
	</div>

	<div class="budget-box">
		
	</div>

	<table id="ledgerTable">
		<thead>
			<th style="width:1px">#</th>
			<th style="width:70px;">SDA CODE</th>
			<th>STAFF NAME</th>
			<th style="width:140px;">DESIGNATION</th>
			<th style="width:120px;">FACILITY</th>
			<th style="width:100px;">ARRIVED</th>
			<th style="width:100px">AMOUNT</th>
			<th style="width:80px">ACTIONS</th>
		</thead>

		<tbody>
		</tbody>
	</table>

	<div style="margin: 5px 0 10px;">
		<span class="button task right" id="addRequest">
			<i class="icon-print small"></i>
			Print
		</span>
	</div>
</div>

<div id="addStaff-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>
        <h3>ADD STAFF</h3>
    </div>
    <div class="dialog-content">
        <ul>
            <li>
                <label for="name">NAME:</label>
                <input type="text" id="name"/>
            </li>
            <li>
                <label for="designation">
                    DESIGNATION :
                </label>

                <select id="designation">

                </select>
            </li>
            <li>
                <label for="facility">
                    FACILITY :
                </label>
                <select id="facility" class="required">
                    <option value="">&nbsp;</option>
                    <% locations.eachWithIndex { loc, index -> %>
                    <option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
                    <% } %>
                </select>
            </li>
            <li>
                <label for="amount">AMOUNT:</label>
                <input type="text" id="amount"/>
            </li></ul>
        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>

<div id="editStaff-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>
        <h3>EDIT STAFF</h3>
    </div>
    <div class="dialog-content">
        <ul>
            <li>
                <label for="name">NAME:</label>
                <input type="text" id="name"/>
            </li>
            <li>
                <label for="designation">
                    DESIGNATION :
                </label>

                <select id="designation">

                </select>
            </li>
            <li>
                <label for="facility">
                    FACILITY :
                </label>
                <select id="facility" class="required">
                    <option value="">&nbsp;</option>
                    <% locations.eachWithIndex { loc, index -> %>
                    <option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
                    <% } %>
                </select>
            </li>
            <li>
                <label for="amount">AMOUNT:</label>
                <input type="text" id="amount"/>
            </li></ul>
        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>
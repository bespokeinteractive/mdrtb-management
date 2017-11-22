<% 
	ui.decorateWith("appui", "standardEmrPage", [title: "Human Resource"])
	ui.includeCss("uicommons", "datatables/dataTables_jui.css")
	ui.includeJavascript("mdrtbregistration", "jq.dataTables.min.js")
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<script>
	var staffTable;
    var staffTableObject;
    var staffResultsData = [];

    var getStaffLists = function(){
        staffTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');

        var requestData = {
            location:	jq('#locations').val(),
        }

        jq.getJSON('${ ui.actionLink("mdrtbmanagement", "humanResources", "getStaffLists") }', requestData)
            .success(function (data) {
                updateLedgerEntriesResults(data);
            }).error(function (xhr, status, err) {
                updateLedgerEntriesResults([]);
            }
        );
    };
	
	var updateLedgerEntriesResults = function(results){
        staffResultsData = results || [];
        var dataRows = [];
        _.each(staffResultsData, function(result){
			var icons = "<a data-idnt='" + result.id + "' class='edit-staff'>Edit</a> |<a data-idnt='" + result.id + "' class='transfer-staff'><i class='icon-remove small'></i></a>"
			
			
            dataRows.push([0, result.designation.code, result.name.toUpperCase(), result.designation.name.toUpperCase(), result.location.name.toUpperCase(), result.date, result.amount.toString().formatToAccounting(), icons]);
        });

        staffTable.api().clear();

        if(dataRows.length > 0) {
            staffTable.fnAddData(dataRows);
        }

        refreshInTable(staffResultsData, staffTable);
    };
	
	var refreshInTable = function (resultData, dTable) {
        var rowCount = resultData.length;
        if (rowCount == 0) {
            dTable.find('td.dataTables_empty').html("No Records Found");
        }
        dTable.fnPageChange(0);
    };

    var isTableEmpty = function (resultData, dTable) {
        if (resultData.length > 0) {
            return false
        }
        return !dTable || dTable.fnGetNodes().length == 0;
    };
	
	jq(function () {
		staffTableObject = jq("#staffTable");

        staffTable = staffTableObject.dataTable({
            autoWidth: false,
            bFilter: true,
            bJQueryUI: true,
            bLengthChange: false,
            iDisplayLength: 25,
            sPaginationType: "full_numbers",
            bSort: false,
            sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
            oLanguage: {
                "sInfo": "_TOTAL_ Staff Members",
                "sInfoEmpty": " ",
                "sZeroRecords": "No Staff Members Found",
                "sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Staff)",
                "oPaginate": {
                    "sFirst": "First",
                    "sPrevious": "Previous",
                    "sNext": "Next",
                    "sLast": "Last"
                }
            },

            fnDrawCallback : function(oSettings){
                if(isTableEmpty(staffResultsData, staffTable)){
                    return;
                }
            },

            fnRowCallback : function (nRow, aData, index){
                return nRow;
            }
        });

        staffTable.on( 'order.dt search.dt', function () {
            staffTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
                cell.innerHTML = i+1;
            } );
        }).api().draw();

        jq('#filter').on('keyup', function () {
            staffTable.api().search( this.value ).draw();
        });
		
		//End of Datatables
		
		var staffAddEditDialog = emr.setupConfirmationDialog({
			dialogOpts: {
				 overlayClose: false,
				 close: true
			},
			selector: '#update-dialog',
			actions: {
				confirm: function() {					
					if (jq('#name').val().trim() == ''){
						jq().toastmessage('showErrorToast', 'Invalid Names. Kindly provide the correct value for names');
						return false;
					}

					if (jq('#facility').val() == ''){
						jq().toastmessage('showErrorToast', 'Invalid Facility. Kindly provide the correct value for the facility');
						return false;
					}
					
					if (jq('#designation').val() == ''){
						jq().toastmessage('showErrorToast', 'Invalid Designation. Kindly provide the correct value for Designation');
						return false;
					}
					
					var value = jq('#amount').val().replace(',','').replace(' ','');;
					
					if (isNaN(parseFloat(value)) || !isFinite(value) || value < 0) {
						jq().toastmessage('showErrorToast', 'Invalid Amount. Kindly provide the correct value for Amount');
						return false;
					}
					
					var dataString = {
						id: 		jq('#idnt').val(),
						date:		jq('#date-field').val(),
						name:		jq('#name').val(),
						chart:		jq('#designation').val(),
						location:	jq('#facility').val(),
						amount:		jq('#amount').val(),
						note:		jq('#description').val(),
					}
                    jq.ajax({
                        type: "POST",
                        url: '${ui.actionLink("mdrtbmanagement", "HumanResources", "updateStaffList")}',
                        data: dataString,
                        dataType: "json",
                        success: function (data) {
                            if (data.status == "success") {
                                jq().toastmessage('showSuccessToast', data.message);
                                window.location.href = "humanresource.page";
                            }
                            else {
                                jq().toastmessage('showErrorToast', 'Post failed. ' + data.message);
                            }
                        },
                        error: function (data) {
                            jq().toastmessage('showErrorToast', "Post failed. " + data.statusText);
                        }
                    });
				},
				cancel: function() {
					staffAddEditDialog.close();
				}
			}
		});
		
		var transferDialog = emr.setupConfirmationDialog({
			dialogOpts: {
				 overlayClose: false,
				 close: true
			},
			selector: '#transfer-dialog',
			actions: {
				confirm: function() {
					var dataString = {
						id: 		jq('#tidnt').val(),
						note:		jq('#tnotes').val(),
						date:		jq('#tdate-field').val(),
					}
                    jq.ajax({
                        type: "POST",
                        url: '${ui.actionLink("mdrtbmanagement", "HumanResources", "transferStaffList")}',
                        data: dataString,
                        dataType: "json",
                        success: function (data) {
                            if (data.status == "success") {
                                jq().toastmessage('showSuccessToast', data.message);
                                window.location.href = "humanresource.page";
                            }
                            else {
                                jq().toastmessage('showErrorToast', 'Post failed. ' + data.message);
                            }
                        },
                        error: function (data) {
                            jq().toastmessage('showErrorToast', "Post failed. " + data.statusText);
                        }
                    });					
				},
				cancel: function() {
					transferDialog.close();
				}
			}
		});
		
		jq('#locations').change(function(){
			getStaffLists();
		});
		
		jq('#addStaff').click(function(){
			jq('#add-dialog .dialog-header h3').text('ADD NEW STAFF');
			jq('#idnt').val(0);
			jq('#name').val('');
			jq('#designation').val('');
			jq('#facility').val('');
			jq('#amount').val('0.00');
			jq('#description').val('');
		   
			staffAddEditDialog.show();
		});
		
		jq('table').on('click','.edit-staff', function(){
			jq('#add-dialog .dialog-header h3').text('EDIT STAFF');

			var idnt = jq(this).data('idnt');
			
			jq.getJSON('${ ui.actionLink("mdrtbmanagement", "HumanResources", "getStaffDetails") }', {
                id: idnt
            }).success(function (data) {
                jq('#idnt').val(idnt);
                jq('#name').val(data.name.toUpperCase());
                jq('#date-field').val(data.date);
                jq('#date-display').val(data.disp).change();
				jq('#designation').val(data.designation);
				jq('#facility').val(data.location);
				jq('#amount').val(data.amount.toString().formatToAccounting());
				jq('#description').val(data.notes);
               
				staffAddEditDialog.show();
            });
		});
		
		jq('table').on('click','.transfer-staff', function(){
			var idnt = jq(this).data('idnt');
			
			jq.getJSON('${ ui.actionLink("mdrtbmanagement", "HumanResources", "getStaffDetails") }', {
                id: idnt
            }).success(function (data) {
                jq('#tidnt').val(idnt);
                jq('#tname').val(data.name.toUpperCase());
				jq('#tdesignation').val(data.desc.toUpperCase());
				jq('#tfacility').val(data.loc.toUpperCase());
				jq('#tnotes').val('');
               
				transferDialog.show();
            });
		});

		jq('#amount').change(function() {
			var val = jq(this).val();
			jq(this).val(val.toString().formatToAccounting()!='NaN'?val.toString().formatToAccounting():'');
		});
		
		jq('#amount').focus(function() {
			var val = jq(this).val().replace(',','').replace(' ','');;
			if (isNaN(parseFloat(val)) || isFinite(val) && val == 0) {
				jq(this).val('');
			}
		});
		
		jq('table').on('click','.remove-staff', function(){
			//editStaffDialog.show();
		});
		 
		getStaffLists();
	});
</script>

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
	#staffTable{
		font-size: 12px;
		margin-top: 5px;
	}
	#staffTable th:last-child,
	#staffTable td:last-child{
		text-align: center;
	}
	#staffTable td:first-child{
		text-align: center;
	}
	#staffTable th:nth-child(7),
	#staffTable td:nth-child(7){
		text-align: right;
	}
	#filter {
		margin-right:3px;
	}
	#addStaff{
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
	td a{
		cursor: pointer;
	}
	i.icon-remove{
		color: f00;
	}
	.add-on {
		display: inline-block;
		margin-right: -35px;
	}
</style>

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

	<table id="staffTable">
		<thead>
			<th style="width:1px">#</th>
			<th style="width:70px;">SDA CODE</th>
			<th>STAFF NAME</th>
			<th style="width:140px;">DESIGNATION</th>
			<th style="width:120px;">FACILITY</th>
			<th style="width:100px;">ARRIVED</th>
			<th style="width:80px">AMOUNT</th>
			<th style="width:60px">ACTIONS</th>
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

<div id="update-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>
        <h3>ADD STAFF</h3>
    </div>
    <div class="dialog-content">
        <ul>
            <li>
                <label for="name">NAME:</label>
                <input type="text" id="name"/>
                <input type="hidden" id="idnt"/>
            </li>
			
            <li>
                <label for="designation">
                    DESIGNATION :
                </label>

                <select id="designation">
					<option value="">&nbsp;</option>
					<% charts.eachWithIndex { chart, index -> %>
						<option value="${chart.id}">${chart.name}</option>
                    <% } %>
                </select>
            </li>
			
            <li>
                <label for="facility">
                    FACILITY :
                </label>
				
                <select id="facility">
                    <option value="">&nbsp;</option>
                    <% locations.eachWithIndex { loc, index -> %>
						<option value="${loc.id}"  ${loc==location?'selected':''} '>${loc.name}</option>
                    <% } %>
                </select>
            </li>

			<li>
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'update.date', id: 'date', label: 'DATE:', useTime: false, defaultToday: true, endDate: new Date()])}
			</li>
			
            <li>
                <label for="amount">AMOUNT:</label>
                <input type="text" id="amount"/>
            </li>
			
			<li>
                <label for="description">DESCRIPTION:</label>
                <textarea id="description" style="height:100px"></textarea>
            </li>			
		</ul>
		
        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>

<div id="transfer-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>
        <h3>TRANSFER OUT</h3>
    </div>
    <div class="dialog-content">
        <ul>
            <li>
                <label for="tname">NAME:</label>
                <input type="text" id="tname" readonly=""/>
                <input type="hidden" id="tidnt"/>
            </li>
			
            <li>
                <label for="designation">
                    DESIGNATION :
                </label>
                <input type="text" id="tdesignation" readonly=""/>
            </li>
			
            <li>
                <label for="facility">
                    FACILITY :
                </label>				
                <input type="text" id="tfacility" readonly=""/>
            </li>

			<li>
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'update.date', id: 'tdate', label: 'TRANSFER DATE:', useTime: false, defaultToday: true, endDate: new Date()])}
			</li>
			
			<li>
                <label for="tnotes">DESCRIPTION:</label>
                <textarea id="tnotes" style="height:100px"></textarea>
            </li>			
		</ul>
		
        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>
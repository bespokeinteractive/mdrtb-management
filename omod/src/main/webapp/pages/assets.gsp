<% 
	ui.decorateWith("appui", "standardEmrPage", [title: "Asset Register"])
	ui.includeCss("uicommons", "datatables/dataTables_jui.css")
	ui.includeJavascript("mdrtbregistration", "jq.dataTables.min.js")
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<script>
	var assetsTable;
    var assetsTableObject;
    var assetsResultsData = [];

    var getAssetsLists = function(){
        assetsTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');

        var requestData = {
            location:	jq('#locations').val(),
        }

        jq.getJSON('${ ui.actionLink("mdrtbmanagement", "Assets", "getAssetsLists") }', requestData)
            .success(function (data) {
                updateAssetsListResults(data);
            }).error(function (xhr, status, err) {
                updateAssetsListResults([]);
            }
        );
    };
	
	var updateAssetsListResults = function(results){
        assetsResultsData = results || [];
        var dataRows = [];
        _.each(assetsResultsData, function(result){
			var icons = "<a data-idnt='" + result.id + "' class='edit-asset'>Edit</a>";
			var retired = result.retiredOn;
			var proceed = (result.retiredProceeds?result.retiredProceeds:0).toString().formatToAccounting();
			var assignd = result.assignedTo==''?'N/A':result.assignedTo.toUpperCase();
			
			if (retired == null){
				icons +=" |<a data-idnt='" + result.id + "' class='retire-asset'><i class='icon-remove small'></i></a>";
				retired = 'N/A';
				proceed = '&mdash;';
			}
			
            dataRows.push([0, result.serial, result.description.toUpperCase(), assignd, result.date, result.acquiredCost.toString().formatToAccounting(), retired, proceed, icons]);
        });

        assetsTable.api().clear();

        if(dataRows.length > 0) {
            assetsTable.fnAddData(dataRows);
        }

        refreshInTable(assetsResultsData, assetsTable);
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
		assetsTableObject = jq("#assetsTable");

        assetsTable = assetsTableObject.dataTable({
            autoWidth: false,
            bFilter: true,
            bJQueryUI: true,
            bLengthChange: false,
            iDisplayLength: 25,
            sPaginationType: "full_numbers",
            bSort: false,
            sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
            oLanguage: {
                "sInfo": "_TOTAL_ Assets",
                "sInfoEmpty": " ",
                "sZeroRecords": "No Assets Found",
                "sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Assets)",
                "oPaginate": {
                    "sFirst": "First",
                    "sPrevious": "Previous",
                    "sNext": "Next",
                    "sLast": "Last"
                }
            },

            fnDrawCallback : function(oSettings){
                if(isTableEmpty(assetsResultsData, assetsTable)){
                    return;
                }
            },

            fnRowCallback : function (nRow, aData, index){
                return nRow;
            }
        });

        assetsTable.on( 'order.dt search.dt', function () {
            assetsTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
                cell.innerHTML = i+1;
            } );
        }).api().draw();

        jq('#filter').on('keyup', function () {
            assetsTable.api().search( this.value ).draw();
        });
		
		//End of Datatables
		
		var updateDialog = emr.setupConfirmationDialog({
			dialogOpts: {
				 overlayClose: false,
				 close: true
			},
			selector: '#update-dialog',
			actions: {
				confirm: function() {					
					if (jq('#serial').val().trim() == ''){
						jq().toastmessage('showErrorToast', 'Invalid Serial. Kindly provide the correct value for Serial');
						return false;
					}

					if (jq('#description').val() == ''){
						jq().toastmessage('showErrorToast', 'Invalid Description. Kindly provide the correct value for the Description');
						return false;
					}
					
					var value = jq('#amount').val().replace(',','').replace(' ','');
					var costs = jq('#cost').val().replace(',','').replace(' ','');
					
					if (isNaN(parseFloat(value)) || !isFinite(value) || value < 0) {
						jq().toastmessage('showErrorToast', 'Invalid Acquisition Amount. Kindly provide the correct value for Amount');
						return false;
					}
					
					if (isNaN(parseFloat(costs)) || !isFinite(costs)) {
						jq().toastmessage('showErrorToast', 'Invalid Local Acquisition Cost. Kindly provide the correct value for Amount');
						return false;
					}
					
					var dataString = {
						id: 		jq('#idnt').val(),
						date:		jq('#date-field').val(),
						serial:		jq('#serial').val(),
						location:	jq('#locations').val(),
						description:jq('#description').val(),
						amount:		value,
						costs:		costs,
						assigned:	jq('#assigned').val(),
					}
					
                    jq.ajax({
                        type: "POST",
                        url: '${ui.actionLink("mdrtbmanagement", "Assets", "updateAssetsList")}',
                        data: dataString,
                        dataType: "json",
                        success: function (data) {
                            if (data.status == "success") {
                                jq().toastmessage('showSuccessToast', data.message);
                                window.location.href = "assets.page";
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
					updateDialog.close();
				}
			}
		});
		
		var retireDialog = emr.setupConfirmationDialog({
			dialogOpts: {
				overlayClose: false,
				close: true
			},
			selector: '#retire-dialog',
			actions: {
				confirm: function() {
					var value = jq('#ramount').val().replace(',','').replace(' ','');
				
					if (isNaN(parseFloat(value)) || !isFinite(value) || value < 0) {
						jq().toastmessage('showErrorToast', 'Invalid Acquisition Amount. Kindly provide the correct value for Amount');
						return false;
					}
					
					var dataString = {
						id: 		jq('#ridnt').val(),
						date:		jq('#rdate-field').val(),
						amount:		value,
					}
					
                    jq.ajax({
                        type: "POST",
                        url: '${ui.actionLink("mdrtbmanagement", "Assets", "retireAssetsList")}',
                        data: dataString,
                        dataType: "json",
                        success: function (data) {
                            if (data.status == "success") {
                                jq().toastmessage('showSuccessToast', data.message);
                                window.location.href = "assets.page";
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
					retireDialog.close();
				}
			}
		});
		
		//End of Dialog Boxes
		
		jq('#locations').change(function(){
			getAssetsLists();
		});
		
		jq('#addAssets').click(function(){
			jq('#update-dialog .dialog-header h3').text('ADD NEW ASSET');
			jq('#idnt').val(0);
			jq('#serial').val('');
			jq('#description').val('');
			jq('#amount').val('0.00');
			jq('#cost').val('0.00');
			jq('#assigned').val('');
		   
			updateDialog.show();
		});
		
		jq('table').on('click','.edit-asset', function(){
			jq('#update-dialog .dialog-header h3').text('EDIT ASSET');
			var idnt = jq(this).data('idnt');
			
			jq.getJSON('${ ui.actionLink("mdrtbmanagement", "Assets", "getAssetDetails") }', {
                id: idnt,
            }).success(function (data) {
				jq('#idnt').val(idnt);
                jq('#date-field').val(data.date);
                jq('#date-display').val(data.disp).change();
				jq('#serial').val(data.serial);
				jq('#description').val(data.description);
				jq('#amount').val(data.amount.toString().formatToAccounting());
				jq('#cost').val(data.costs.toString().formatToAccounting());
				jq('#assigned').val(data.assigned);
               
				updateDialog.show();
            });
		});
		
		jq('table').on('click','.retire-asset', function(){
			var idnt = jq(this).data('idnt');
			
			jq.getJSON('${ ui.actionLink("mdrtbmanagement", "Assets", "getAssetDetails") }', {
                id: idnt,
            }).success(function (data) {
				jq('#ridnt').val(idnt);
				jq('#rserial').val(data.serial);
				jq('#rdescription').val(data.description);
				jq('#ramount').val('0.00');
               
				retireDialog.show();
            });
		});
		
		jq('#ramount, #amount, #cost').change(function() {
			var val = jq(this).val();
			jq(this).val(val.toString().formatToAccounting()!='NaN'?val.toString().formatToAccounting():'');
		});
		
		jq('#ramount, #amount, #cost').focus(function() {
			var val = jq(this).val().replace(',','').replace(' ','');;
			if (isNaN(parseFloat(val)) || isFinite(val) && val == 0) {
				jq(this).val('');
			}
		});
		
		getAssetsLists();
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
	#assetsTable{
		font-size: 12px;
		margin-top: 5px;
	}
	#assetsTable td:first-child,
	#assetsTable th:last-child,
	#assetsTable td:last-child{
		text-align: center;
	}
	#assetsTable td:nth-child(6),
	#assetsTable td:nth-child(8){
		text-align: right;
	}
	#filter {
		margin-right:3px;
	}
	#addAssets{
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
            Asset Register
        </li>
    </ul>
</div>

<div class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-ambulance small"></i>ASSET REGISTER &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div id="show-icon">
		<span class="button confirm right" id="addAssets">
			<i class="icon-plus small"></i>
		</span>
		
		<select id="locations" class="right" style="width:200px;">
			<% locations.eachWithIndex { loc, index -> %>
				<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
			<% } %>
		</select>
		
		<input id="filter" class="right" placeholder="Filter Assets" />
		<i class="icon-filter small right"></i>
		
		<div class="clear both"></div>
	</div>

	<div class="budget-box">
		
	</div>
	
	<table id="assetsTable">
		<thead>
			<th style="width:1px">#</th>
			<th style="width:65px;">ASSET NO.</th>
			<th>DESCRIPTION</th>
			<th style="width:120px;">ASSIGNED TO</th>
			<th style="width:70px;">ACQUIRED</th>
			<th style="width:80px;">COST</th>
			<th style="width:70px">RETIRED</th>
			<th style="width:80px">PROCEEDS</th>
			<th style="width:70px">ACTIONS</th>
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
        <h3>ADD ASSETS</h3>
    </div>
    <div class="dialog-content">
        <ul>
            <li>
                <label for="serial">SERIAL:</label>
                <input type="text" id="serial"/>
                <input type="hidden" id="idnt"/>
            </li>
			
            <li>
                <label for="description">
                    DESCRIPTION:
                </label>
				<input type="text" id="description" placeholder="Model, Mfg, Serial No. etc"/>
            </li>

			<li>
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'update.date', id: 'date', label: 'ACQUIRED ON:', useTime: false, defaultToday: true, endDate: new Date()])}
			</li>
			
            <li>
                <label for="amount">COST IN \$:</label>
                <input type="text" id="amount"/>
            </li>
			
			<li>
                <label for="cost">LOCAL COST:</label>
                <input type="text" id="cost"/>
            </li>
			
			<li>
                <label for="assigned">
                    ASSIGNED TO:
                </label>
				<input type="text" id="assigned" placeholder="Model, Mfg, Serial No. etc"/>
            </li>		
		</ul>
		
        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>

<div id="retire-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-arrow-left"></i>
        <h3>RETIRE ASSETS</h3>
    </div>
    <div class="dialog-content">
        <ul>
            <li>
                <label for="rserial">SERIAL:</label>
                <input type="text" id="rserial" readonly="" />
                <input type="hidden" id="ridnt"/>
            </li>
			
            <li>
                <label for="rdescription">
                    DESCRIPTION:
                </label>
				<input type="text" id="rdescription" readonly="" />
            </li>

			<li>
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'retire.date', id: 'rdate', label: 'RETIRED ON:', useTime: false, defaultToday: true, endDate: new Date()])}
			</li>
			
            <li>
                <label for="ramount">PROCEEDS:</label>
                <input type="text" id="ramount"/>
            </li>
		</ul>
		
        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>
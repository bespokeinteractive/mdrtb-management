<script>
	var approvedTable;
	var approvedTableObject;
	var approvedResultsData = [];
	
	var getApprovedCash = function(){
		approvedTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');
		
		var requestData = {
			approved: true
		}
		
		jq.getJSON('${ ui.actionLink("mdrtbmanagement", "cashdisbursement", "listCashDisbursements") }', requestData)
			.success(function (data) {
				updateApprovedResults(data);
			}).error(function (xhr, status, err) {
				updateApprovedResults([]);
			}
		);
	};
	
	var updateApprovedResults = function(results){
        approvedResultsData = results || [];
		var dataRows = [];
		_.each(approvedResultsData, function(result){
			var agency = '<a href="cashrequestview.page?id=' + result.id + '">' + result.agency.name + '</a>';
			var icons = '';
			var status = '';
			
			if(result.confirmedOn == null){
				status = 'Approved';
				icons = '<a class="confirm-receipt" data-idnt="'+ result.id +'">Confirm</a> | <a href="cashrequestview.page?id=' + result.id + '">View</a>';
			}else {
				status = 'Received';
				icons = '<a href="cashrequestview.page?id=' + result.id + '"><i class="icon-file-alt small icon"> </i> View Transc</a>';
			}
			
			dataRows.push([0, result.date, result.period, agency, status, result.amount.toString().formatToAccounting(), result.estimate.toString().formatToAccounting(), icons]);
		});

        approvedTable.api().clear();
		
		if(dataRows.length > 0) {
            approvedTable.fnAddData(dataRows);
		}

		refreshInTable(approvedResultsData, approvedTable);
	};

    jq(function () {
        approvedTableObject = jq("#approvedList");

        approvedTable = approvedTableObject.dataTable({
			autoWidth: false,
			bFilter: true,
			bJQueryUI: true,
			bLengthChange: false,
			iDisplayLength: 25,
			sPaginationType: "full_numbers",
			bSort: false,
			sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
			oLanguage: {
				"sInfo": "Disbursements",
				"sInfoEmpty": " ",
				"sZeroRecords": "No Disbursements Found",
				"sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Transactions)",
				"oPaginate": {
					"sFirst": "First",
					"sPrevious": "Previous",
					"sNext": "Next",
					"sLast": "Last"
				}
			},

			fnDrawCallback : function(oSettings){
				if(isTableEmpty(approvedResultsData, approvedTable)){
					return;
				}
			},
			
			fnRowCallback : function (nRow, aData, index){
				return nRow;
			}
		});

        approvedTable.on( 'order.dt search.dt', function () {
            approvedTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
				cell.innerHTML = i+1;
			} );
		}).api().draw();
		
		jq('#fundApproved').on('keyup', function () {
            approvedTable.api().search( this.value ).draw();
		});
		
		jq('#approvedList').on('click', '.confirm-receipt', function(){
			var idnt = jq(this).data('idnt');
			
            jq.getJSON('${ ui.actionLink("mdrtbmanagement", "cashdisbursement", "getDisbursementsDetails") }', {
                id: idnt
            }).success(function (data) {
                jq('#disIdnt').val(idnt);
                jq('#disName').val(data.name);
                jq('#disAmount').val(data.amount.toString().formatToAccounting());
                jq('#disAdjust').val(data.estimate.toString().formatToAccounting());
                jq('#disConfirm').val('');
				
				confirmDialog.show();
            });
		
		});
		
		var confirmDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#confirm-dialog',
            actions: {
                confirm: function () {
                    var dataString = {
						id: 	jq('#disIdnt').val(),
						date:	jq('#disDate-field').val(),
						note:	jq('#disConfirm').val()
					}

                    jq.ajax({
                        type: "POST",
                        url: '${ui.actionLink("mdrtbmanagement", "cashdisbursement", "confirmDisbursement")}',
                        data: dataString,
                        dataType: "json",
                        success: function (data) {
                            if (data.status == "success") {
                                jq().toastmessage('showSuccessToast', data.message);
                                window.location.href = "cashdisbursement.page?tab=approved";
                            }
                            else {
                                jq().toastmessage('showErrorToast', 'Post failed. ' + data.message);
                            }
                        },
                        error: function (data) {
                            jq().toastmessage('showErrorToast', "Post failed. " + data.statusText);
                        }
                    });

                    confirmDialog.close();
                },
                cancel: function () {
                    confirmDialog.close();
                }
            }
        });

        getApprovedCash();
    });
</script>

<div class="dashboard clear">
    <div class="info-section">
        <div class="info-header">
            <i class="icon-filter"></i>
            <h3 class="name">Approved</h3>
			<input id="fundApproved" type="text" value="" name="cash.approved" placeholder="Filter Disbursements" style="width:78%; margin:-40px 5px 0px 10px; padding:0px 15px;">
        </div>
    </div>
</div>

<table id="approvedList">
    <thead>
		<th style="width:1px">#</th>
		<th style="width:90px">DATE</th>
		<th style="width:80px">QUARTER</th>
		<th>SUB-RECIPIENT</th>
		<th style="width:80px;">STATUS</th>
		<th style="width:100px;">APPROVED</th>
	    <th style="width:100px;">ADJ ESTIMATE</th>
		<th style="width:100px">ACTIONS</th>
    </thead>

    <tbody>    
    </tbody>
</table>

<div id="confirm-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>

        <h3>CONFIRM RECEIPT</h3>
    </div>

    <div class="dialog-content">
		<ul>
			<li>
				<label for="addNames">AGENCY:</label>
				<input type="text" id="disName" readonly=""/>
				<input type="hidden" id="disIdnt" />
			</li>

			<li>
				<label for="editNames">AMOUNT:</label>
				<input type="text" id="disAmount" readonly=""/>
			</li>

			<li>
				<label for="editNames">ADJUSTMENT:</label>
				<input type="text" id="disAdjust" readonly=""/>
			</li>

			<li>
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'confirm.date', id: 'disDate', label: 'DATE:', useTime: false, defaultToday: true])}
			</li>
			
			<li>
				<label for="editNames">CONFIRM:</label>
				<textarea id="disConfirm" placeholder="Narration"></textarea>
			</li>
		</ul>

        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>
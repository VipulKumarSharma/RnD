(function(a){a.fn.extend({setColumns:function(b){b=a.extend({top:0,left:0,width:200,height:195,modal:false,drag:true,closeicon:"ico-close.gif?buildstamp=2_0_0",beforeShowForm:null,afterShowForm:null,afterSubmitForm:null},a.jgrid.col,b||{});return this.each(function(){var j=this;if(!j.grid){return}var l=typeof b.beforeShowForm==="function"?true:false;var d=typeof b.afterShowForm==="function"?true:false;var e=typeof b.afterSubmitForm==="function"?true:false;if(!b.imgpath){b.imgpath=j.p.imgpath}var c=a("table:first",j.grid.bDiv).attr("id");var f={themodal:"colmod"+c,modalhead:"colhd"+c,modalcontent:"colcnt"+c};var h="ColTbl_"+c;if(a("#"+f.themodal).html()!=null){if(l){b.beforeShowForm(a("#"+h))}viewModal("#"+f.themodal,{modal:b.modal});if(d){b.afterShowForm(a("#"+h))}}else{var k=a("<table id='"+h+"' class='ColTable'><tbody></tbody></table>");for(i=0;i<this.p.colNames.length;i++){if(!j.p.colModel[i].hidedlg){a(k).append("<tr><td ><input type='checkbox' id='col_"+this.p.colModel[i].name+"' class='cbox' value='T' "+((this.p.colModel[i].hidden==undefined)?"checked":"")+"/><label for='col_"+this.p.colModel[i].name+"'>"+this.p.colNames[i]+"("+this.p.colModel[i].name+")</label></td></tr>")}}var g="<input id='dData' type='button' value='"+b.bSubmit+"'/>";var m="<input id='eData' type='button' value='"+b.bCancel+"'/>";a(k).append("<tr><td class='ColButton'>"+g+"&nbsp;"+m+"</td></tr>");createModal(f,k,b,j.grid.hDiv,j.grid.hDiv);if(b.drag){DnRModal("#"+f.themodal,"#"+f.modalhead+" td.modaltext")}a("#dData","#"+h).click(function(n){for(i=0;i<j.p.colModel.length;i++){if(!j.p.colModel[i].hidedlg){if(a("#col_"+j.p.colModel[i].name).attr("checked")){a(j).showCol(j.p.colModel[i].name);a("#col_"+j.p.colModel[i].name).attr("defaultChecked",true)}else{a(j).hideCol(j.p.colModel[i].name);a("#col_"+j.p.colModel[i].name).attr("defaultChecked","")}}}a("#"+f.themodal).jqmHide();if(e){b.afterSubmitForm(a("#"+h))}return false});a("#eData","#"+h).click(function(n){a("#"+f.themodal).jqmHide();return false});if(l){b.beforeShowForm(a("#"+h))}viewModal("#"+f.themodal,{modal:b.modal});if(d){b.afterShowForm(a("#"+h))}}})}})})(jQuery);
	$(function() {
		$.ui.autocomplete.prototype._renderItem = function (ul, item) {
		    item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(this.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>");
		    return $("<li></li>")
		            .data("item.autocomplete", item)
		            .append("<a>" + item.label + "</a><span style='display: none;'>" +item.id+ "</span>")
		            .appendTo(ul);
		};	
	});

var DrawMaps = (function () {

	function Travel (date, fromCountry, toCountry) {
		var that = this;

		that.fromPos = {
			x: fromCountry.x,
			y: fromCountry.y
		};

		that.toPos = {
			x: toCountry.x,
			y: toCountry.y
		};

		that.date = new Date(date);

		that.draw = function (ctx) {
			var today = new Date();
			if (that.date < today) {
				ctx.strokeStyle = "rgba(75,251,53,0.4)";
				ctx.lineWidth = 4;
			} else {
				ctx.strokeStyle = "rgba(255,0,0,0.6)";
				ctx.lineWidth = 3;
			}

			ctx.beginPath();
			ctx.moveTo(that.fromPos.x, that.fromPos.y);
			var cpx = that.fromPos.x + ((that.toPos.x - that.fromPos.x) / 2);

			if (that.fromPos.y <= that.toPos.y) {
				var cpy = that.fromPos.y - 50;
			} else {
				var cpy = that.toPos.y - 50;
			}
			ctx.quadraticCurveTo(cpx, cpy, that.toPos.x, that.toPos.y);
	    ctx.stroke();


		};
	};

	function Map (ctx) {
		var that = this;

		that.drawNewMap = function(travelData) {
			// that.clickHandler();
			travelData.forEach (function(travel) {
				new Travel(travel.date, travel.from_country, travel.to_country)
						.draw(ctx);
			})
		};

		// that.clickHandler = function () {
		// 	$('canvas').click(function (event) {
		// 		console.log(event.pageX);
		// 		console.log(event.pageY);
		// 	});
		// };

	};

	return {
		Map: Map
	};
})();

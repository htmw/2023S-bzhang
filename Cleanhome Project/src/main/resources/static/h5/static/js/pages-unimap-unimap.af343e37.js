(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-unimap-unimap"],{"2dc4":function(e,t,n){"use strict";n.r(t);var a=n("70a2"),r=n("5474");for(var i in r)["default"].indexOf(i)<0&&function(e){n.d(t,e,(function(){return r[e]}))}(i);n("2fae");var o=n("f0c5"),u=Object(o["a"])(r["default"],a["b"],a["c"],!1,null,"21df4b3b",null,!1,a["a"],void 0);t["default"]=u.exports},"2fae":function(e,t,n){"use strict";var a=n("9757"),r=n.n(a);r.a},5474:function(e,t,n){"use strict";n.r(t);var a=n("c5fb"),r=n.n(a);for(var i in a)["default"].indexOf(i)<0&&function(e){n.d(t,e,(function(){return a[e]}))}(i);t["default"]=r.a},"70a2":function(e,t,n){"use strict";n.d(t,"b",(function(){return r})),n.d(t,"c",(function(){return i})),n.d(t,"a",(function(){return a}));var a={uNavbar:n("7378").default},r=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("v-uni-view",[n("u-navbar",{attrs:{title:"地图",border:!0,placeholder:!0,autoBack:!1},on:{leftClick:function(t){arguments[0]=t=e.$handleEvent(t),e.goBack()}}}),n("v-uni-view",{staticClass:"mycontent"},[n("v-uni-map",{ref:"map",staticClass:"map",attrs:{id:"map","show-location":!0,latitude:e.latitude,longitude:e.longitude},on:{markertap:function(t){arguments[0]=t=e.$handleEvent(t),e.clickMarker.apply(void 0,arguments)},click:function(t){arguments[0]=t=e.$handleEvent(t),e.clickMap.apply(void 0,arguments)}}})],1)],1)},i=[]},"918f":function(e,t,n){var a=n("24fb");t=a(!1),t.push([e.i,".mycontent[data-v-21df4b3b]{width:%?750?%;height:%?1300?%}.map[data-v-21df4b3b]{width:%?750?%;height:%?1300?%}",""]),e.exports=t},9757:function(e,t,n){var a=n("918f");a.__esModule&&(a=a.default),"string"===typeof a&&(a=[[e.i,a,""]]),a.locals&&(e.exports=a.locals);var r=n("4f06").default;r("4b4a7803",a,!0,{sourceMap:!1,shadowMode:!1})},b85c:function(e,t,n){"use strict";n("7a82"),Object.defineProperty(t,"__esModule",{value:!0}),t.default=function(e,t){var n="undefined"!==typeof Symbol&&e[Symbol.iterator]||e["@@iterator"];if(!n){if(Array.isArray(e)||(n=(0,a.default)(e))||t&&e&&"number"===typeof e.length){n&&(e=n);var r=0,i=function(){};return{s:i,n:function(){return r>=e.length?{done:!0}:{done:!1,value:e[r++]}},e:function(e){throw e},f:i}}throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}var o,u=!0,l=!1;return{s:function(){n=n.call(e)},n:function(){var e=n.next();return u=e.done,e},e:function(e){l=!0,o=e},f:function(){try{u||null==n["return"]||n["return"]()}finally{if(l)throw o}}}},n("a4d3"),n("e01a"),n("d3b7"),n("d28b"),n("3ca3"),n("ddb0"),n("d9e2"),n("d401");var a=function(e){return e&&e.__esModule?e:{default:e}}(n("06c5"))},c5fb:function(e,t,n){"use strict";n("7a82");var a=n("4ea4").default;Object.defineProperty(t,"__esModule",{value:!0}),t.default=void 0,n("e9c4"),n("14d9"),n("d3b7");var r=a(n("c7eb")),i=a(n("b85c")),o=a(n("1da1")),u=n("2798"),l=n("2379"),d={data:function(){return{latitude:23.099994,longitude:113.32452,fileUrl:u.fileUrl}},onLoad:function(e){},onReady:function(){var e=this;this._mapContext=uni.createMapContext("map",this),this._mapContext.initMarkerCluster({enableDefaultStyle:!1,zoomOnClick:!0,gridSize:60,complete:function(e){console.log("initMarkerCluster",e)}}),this._mapContext.on("markerClusterCreate",(function(e){console.log("markerClusterCreate",e)})),this.addMarkers(),uni.getLocation({success:function(t){e.latitude=t.latitude,e.longitude=t.longitude}}),(0,u.listj)({params:{table:"shop"}}).then((function(t){e.addMarkersCus(t,!1)}))},methods:{clickMarker:function(e){var t=e.markerId;console.log(t),uni.navigateTo({url:"/pages/shops/shopdetail?pid="+t})},clickMap:function(e){console.log(e.detail.latitude)},goBack:function(){uni.navigateBack({delta:1})},addMarker:function(e,t){this._mapContext.addMarkers({markers:[{latitude:e,longitude:t}],clear:!1,complete:function(e){}})},addMarkersCus:function(e,t){var n=this;return(0,o.default)((0,r.default)().mark((function a(){var o,u,d,c,s,f,h,p,b;return(0,r.default)().wrap((function(a){while(1)switch(a.prev=a.next){case 0:o=[],u=(0,i.default)(e),a.prev=2,u.s();case 4:if((d=u.n()).done){a.next=21;break}if(c=d.value,s=null,t&&(s={width:50,height:30,borderWidth:1,borderRadius:10,bgColor:"#ffffff",content:c.title}),f=c.latitude,h=c.longitude,f&&h){a.next=17;break}return a.next=13,l.ideautil.getPointByAddress(c.address);case 13:p=a.sent,console.log("getPointByAddress:"+JSON.stringify(p)),f=p.latitude,h=p.longitude;case 17:b={id:c.id,latitude:f,longitude:h,iconPath:n.fileUrl+c.img,width:50,height:50,joinCluster:!0,label:s},o.push(b);case 19:a.next=4;break;case 21:a.next=26;break;case 23:a.prev=23,a.t0=a["catch"](2),u.e(a.t0);case 26:return a.prev=26,u.f(),a.finish(26);case 29:n._mapContext.addMarkers({markers:o,clear:!0,complete:function(e){console.log("addMarkers",e)}});case 30:case"end":return a.stop()}}),a,null,[[2,23,26,29]])})))()},addMarkers:function(){var e=this.fileUrl+"4476dd01-e609-4e89-ab36-ff88317f99a7.jpg",t={id:1,iconPath:e,width:50,height:50,joinCluster:!0,label:{width:50,height:30,borderWidth:1,borderRadius:10,bgColor:"#ffffff"}},n=[];[{latitude:23.099994,longitude:113.32452},{latitude:23.099994,longitude:113.32252},{latitude:23.099994,longitude:113.32652},{latitude:23.096994,longitude:113.32952}].forEach((function(e,a){var r=Object.assign({},t,e);r.id=a+1,r.label.content="label ".concat(a+1),n.push(r)})),this._mapContext.addMarkers({markers:n,clear:!1,complete:function(e){console.log("addMarkers",e)}})}}};t.default=d}}]);
<template>
	<view>
		<u-tabbar :value="index" @change="itemChange" :fixed="true" :placeholder="true" :safeAreaInsetBottom="true">
			<u-tabbar-item text="Home" icon="home" ></u-tabbar-item>
			<u-tabbar-item text="photo" icon="photo" ></u-tabbar-item>
			<u-tabbar-item text="play" icon="play-right" ></u-tabbar-item>
			<u-tabbar-item text="account" icon="account" ></u-tabbar-item>
		</u-tabbar>
	</view>
</template>

<script>
	import {
		fileUrl
	} from '@/common/config/api.js';
	import {
		ideautil
	} from '@/common/commontools.js';
	export default {
		name:"pubus-list",
		props: {
			dataList: {
				type: Array,
				require: false,
				default: function(){
					return []
				}
			},
			clickItem: {
				type: Function,
				default: null
			}
		},
		methods: {
			itemChange(){

			},
		},
		data() {
			return {
				fileUrl: fileUrl,
				index:0
			};
		}
	}
</script>

<style>

</style>
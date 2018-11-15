// 对Date的扩展，将 Date 转化为指定格式的String  
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
Date.prototype.Format = function (fmt,dateoption) { //author: meizz
        if(dateoption){
            if(dateoption.day){
                this.setDate(this.getDate() + dateoption.day);
            }
            if(dateoption.month){
                var d = this.getDate();
                this.setMonth(this.getMonth() + dateoption.month);
                if (this.getDate() < d)
                    this.setDate(0);
            }
            if(dateoption.year){
                var m = this.getMonth();
                this.setFullYear(this.getFullYear() + dateoption.year);
                if (m < this.getMonth())
                {
                    this.setDate(0);
                }
            }
        }
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "H+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };
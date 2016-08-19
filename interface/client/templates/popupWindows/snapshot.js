Template["popupWindows_snapshot"].events({
    "click .snapshot-yes button": function(){
        ipc.send("snapshot_chosen", true)
    },
    "click .snapshot-no button": function(){
        ipc.send("snapshot_chosen", false)
    }
})

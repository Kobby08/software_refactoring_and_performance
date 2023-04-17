function countType(type) {
  extractVar;
  chngvartype;
  renamevar;
  chngatrrvar;
  removeattrmod;
  extractsuperclass;
  moveatrr;
  changeatrraccmod;
  addattrmod;
  pullupattr;
  pullupmethod;
  removethrownexctype;
  movemethod;
  changereturn;
  renameparam;
  changeparamtype;
  localparam;
  addparam;
  renamemethod;
  renameattr;
  modatrranno;
  removeparam;
  addmethodanno;
  removeparam;
  addmethodanno;
  changemethaccmod;
  inlinemeth;
  extractmeth;
  removeclassmod;
  removeparammod;
  addvarmod;
  inlinevar;
  removemethmod;
  addclassmod;
  replaceloopwtpipeline;
  addmethodmod;
  extractmovemeth;
  addclassanno;
  changetypedeckind;
  paramvar;
  encapattr;
  replattrwithvar;
  movelinemeth;
  modiparamanno;
  removemethanno;
  modifymethanno;
  removevarmod;
  moveclass;
  replaceanywithlambda;
  changeclassaccmod;
  extractinterface;
  addparammod;
  extractattr;
  renameclass;
  replacevarwithattr;
  modifyclassann;
  addthrownexctype;
  removevaranno;
  moveandrenamemeth;
  reorderparam;
  changethrowexctype;
  extractclass;
  pushdownattr;
  addatrranno;
  removeattranno;
  replacepipelinewithloop;
  moveandrenameattr;
  removeclassanno;
  extractsubclass;
  pushdownmeth;
  mergeparam;
  mergevar;
  splitparam;
  paramattr;
  moveandrename;
  mergeclass;

  switch (type) {
    case "Extract Variable":
      extractVar += 1;
    case "Change Variable Type":
      chngvartype += 1;
    case "Rename Variable":
      renamevar += 1;
    case "Change Attribute Type":
      chngatrrvar += 1;
    case "Remove Attribute Modifier":
      removeattrmod += 1;
    case "Extract Superclass":
      extractsuperclass += 1;
    case "Move Attribute":
      moveatrr += 1;
    case "Change Attribute Access Modifier":
      changeatrraccmod += 1;
    case "Add Attribute Modifier":
      addattrmod += 1;
    case "Pull Up Attribute":
      pullupattr += 1;
    case "Pull Up Method":
      pullupmethod += 1;
    case "Remove Thrown Exception Type":
      removethrownexctype += 1;
    case "Move Method":
      movemethod += 1;
    case "Change Return Type":
      changereturn += 1;
    case "Rename Parameter":
      renameparam += 1;
    case "Change Parameter Type":
      changeparamtype += 1;
    case "Localize Parameter":
      localparam += 1;
    case "Add Parameter":
      addparam += 1;
    case "Rename Method":
      renamemethod += 1;
    case "Rename Attribute":
      renameattr += 1;
    case "Modify Attribute Annotation":
      modatrranno += 1;
    case "Remove Parameter":
      removeparam += 1;
    case "Add Method Annotation":
      addmethodanno += 1;
    case "Change Method Access Modifier":
      changemethaccmod += 1;
    case "Inline Method":
      inlinemeth += 1;
    case "Extract Method":
      extractmeth += 1;
    case "Remove Class Modifier":
      removeclassmod += 1;
    case "Remove Parameter Modifier":
      removeparammod += 1;
    case "Add Variable Modifier":
      addvarmod += 1;
    case "Inline Variable":
      inlinevar += 1;
    case "Remove Method Modifier":
      removemethmod += 1;
    case "Add Class Modifier":
      addclassmod += 1;
    case "Replace Loop With Pipeline":
      replaceloopwtpipeline += 1;
    case "Add Method Modifier":
      addmethodmod += 1;
    case "Extract And Move Method":
      extractmovemeth += 1;
    case "Add Class Annotation":
      addclassanno += 1;
    case "Change Type Declaration Kind":
      changetypedeckind += 1;
    case "Parameterize Variable":
      paramvar += 1;
    case "Encapsulate Attribute":
      encapattr += 1;
    case "Replace Attribute With Variable":
      replattrwithvar += 1;
    case "Move And Inline Method":
      movelinemeth += 1;
    case "Modify Parameter Annotation":
      modiparamanno += 1;
    case "Remove Method Annotation":
      removemethanno += 1;
    case "Modify Method Annotation":
      modifymethanno += 1;
    case "Remove Variable Modifier":
      removevarmod += 1;
    case "Move Class":
      moveclass += 1;
    case "Replace Anonymous With Lambda":
      replaceanywithlambda += 1;
    case "Change Class Access Modifier":
      changeclassaccmod += 1;
    case "Extract Interface":
      extractinterface += 1;
    case "Add Parameter Modifier":
      addparammod += 1;
    case "Extract Attribute":
      extractattr += 1;
    case "Rename Class":
      renameclass += 1;
    case "Replace Variable With Attribute":
      replacevarwithattr += 1;
    case "Modify Class Annotation":
      modifyclassann += 1;
    case "Add Thrown Exception Type":
      addthrownexctype += 1;
    case "Remove Variable Annotation":
      removevaranno += 1;
    case "Move And Rename Method":
      moveandrenamemeth += 1;
    case "Reorder Parameter":
      reorderparam += 1;
    case "Change Thrown Exception Type":
      changethrowexctype += 1;
    case "Extract Class":
      extractclass += 1;
    case "Push Down Attribute":
      pushdownattr += 1;
    case "Add Attribute Annotation":
      addatrranno += 1;
    case "Remove Attribute Annotation":
      removeattranno += 1;
    case "Replace Pipeline With Loop":
      replacepipelinewithloop += 1;
    case "Move And Rename Attribute":
      moveandrenameattr += 1;
    case "Remove Class Annotation":
      removeclassanno += 1;
    case "Extract Subclass":
      extractsubclass += 1;
    case "Push Down Method":
      pushdownmeth += 1;
    case "Merge Parameter":
      mergeparam += 1;
    case "Merge Variable":
      mergevar += 1;
    case "Split Parameter":
      splitparam += 1;
    case "Parameterize Attribute":
      paramattr += 1;
    case "Move And Rename Class":
      moveandrename;
    case "Merge Class":
      mergeclass += 1;

    default:
      break;
  }

  console.log({
    "Extract Variable": extractVar,
    "Change Variable Type": chngvartype,
    "Rename Variable": renamevar,
    "Change Attribute Type": chngatrrvar,
    "Remove Attribute Modifier": removeattrmod,
    "Extract Superclass": extractsuperclass,
    "Move Attribute": moveatrr,
    "Change Attribute Access Modifier": changeatrraccmod,
    "Add Attribute Modifier": addattrmod,
    "Pull Up Attribute": pullupattr,
    "Pull Up Method": pullupmethod,
    "Remove Thrown Exception Type": removethrownexctype,
    "Move Method": movemethod,
    "Change Return Type": changereturn,
    "Rename Parameter": renameparam,
    "Change Parameter Type": changeparamtype,
    "Localize Parameter": localparam,
    "Add Parameter": addparam,
    "Rename Method": renamemethod,
    "Rename Attribute": renameattr,
    "Modify Attribute Annotation": modatrranno,
    "Remove Parameter": removeparam,
    "Add Method Annotation": addmethodanno,
    "Change Method Access Modifier": changemethaccmod,
    "Inline Method": inlinemeth,
    "Extract Method": extractmeth,
    "Remove Class Modifier": removeclassmod,
    "Remove Parameter Modifier": removeparammod,
    "Add Variable Modifier": addvarmod,
    "Inline Variable": inlinevar,
    "Remove Method Modifier": removemethmod,
    "Add Class Modifier": addclassmod,
    "Replace Loop With Pipeline": replaceloopwtpipeline,
    "Add Method Modifier": addmethodmod,
    "Extract And Move Method": extractmovemeth,
    "Add Class Annotation": addclassanno,
    "Change Type Declaration Kind": changetypedeckind,
    "Parameterize Variable": paramvar,
    "Encapsulate Attribute": encapattr,
    "Replace Attribute With Variable": replattrwithvar,
    "Move And Inline Method": movelinemeth,
    "Modify Parameter Annotation": modiparamanno,
    "Remove Method Annotation": removemethanno,
    "Modify Method Annotation": modifymethanno,
    "Remove Variable Modifier": removevarmod,
    "Move Class": moveclass,
    "Replace Anonymous With Lambda": replaceanywithlambda,
    "Change Class Access Modifier": changeclassaccmod,
    "Extract Interface": extractinterface,
    "Add Parameter Modifier": addparammod,
    "Extract Attribute": extractattr,
    "Rename Class": renameclass,
    "Replace Variable With Attribute": replacevarwithattr,
    "Modify Class Annotation": modifyclassann,
    "Add Thrown Exception Type": addthrownexctype,
    "Remove Variable Annotation": removevaranno,
    "Move And Rename Method": moveandrenamemeth,
    "Reorder Parameter": reorderparam,
    "Change Thrown Exception Type": changethrowexctype,
    "Extract Class": extractclass,
    "Push Down Attribute": pushdownattr,
    "Add Attribute Annotation": addatrranno,
    "Remove Attribute Annotation": removeattranno,
    "Replace Pipeline With Loop": replacepipelinewithloop,
    "Move And Rename Attribute": moveandrenameattr,
    "Remove Class Annotation": removeclassanno,
    "Extract Subclass": extractsubclass,
    "Push Down Method": pushdownmeth,
    "Merge Parameter": mergeparam,
    "Merge Variable": mergevar,
    "Split Parameter": splitparam,
    "Parameterize Attribute": paramattr,
    "Move And Rename Class": moveandrename,
    "Merge Class": mergeclass,
  });
}

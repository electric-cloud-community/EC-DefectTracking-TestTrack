@files = (
    ['//property[propertyName="ECDefectTracking::TestTrack::Cfg"]/value', 'TestTrackCfg.pm'],
    ['//property[propertyName="ECDefectTracking::TestTrack::Driver"]/value', 'TestTrackDriver.pm'],
	
    ['//property[propertyName="createConfig"]/value', 'testtrackCreateConfigForm.xml'],
    ['//property[propertyName="editConfig"]/value', 'testtrackEditConfigForm.xml'],
	
    ['//property[propertyName="ec_setup"]/value', 'ec_setup.pl'],
		
	['//procedure[procedureName="LinkDefects"]/propertySheet/property[propertyName="ec_parameterForm"]/value', 'ec_parameterForm-LinkDefects.xml'],	
	['//procedure[procedureName="UpdateDefects"]/propertySheet/property[propertyName="ec_parameterForm"]/value', 'ec_parameterForm-UpdateDefects.xml'],	
	['//procedure[procedureName="CreateDefects"]/propertySheet/property[propertyName="ec_parameterForm"]/value', 'ec_parameterForm-CreateDefects.xml'],	
	['//procedure[procedureName="FileDefect"]/propertySheet/property[propertyName="ec_parameterForm"]/value', 'ec_parameterForm-FileDefect.xml'],	
	['//procedure[procedureName="FileDefectProcedure"]/propertySheet/property[propertyName="ec_parameterForm"]/value', 'ec_parameterForm-FileDefectProcedure.xml'],	
);

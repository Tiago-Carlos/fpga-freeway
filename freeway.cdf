/* Quartus II Version 9.0 Build 235 06/17/2009 Service Pack 2 SJ Web Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Cfg)
		Device PartName(EPF10K20R240) Path("C:/Users/Monitor/Desktop/freeway-master/") File("freeway.sof") MfrSpec(OpMask(1));
	P ActionCode(Ign)
		Device PartName(EPM7128S) MfrSpec(OpMask(0));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;

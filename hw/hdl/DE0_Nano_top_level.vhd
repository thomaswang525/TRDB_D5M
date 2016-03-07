library ieee;
use ieee.std_logic_1164.all;

entity DE0_Nano_top_level is
    port(
        -- CLOCK
        CLOCK_50           : in    std_logic;

        -- SDRAM
        DRAM_ADDR          : out   std_logic_vector(12 downto 0);
        DRAM_BA            : out   std_logic_vector(1 downto 0);
        DRAM_CAS_N         : out   std_logic;
        DRAM_CKE           : out   std_logic;
        DRAM_CLK           : out   std_logic;
        DRAM_CS_N          : out   std_logic;
        DRAM_DQ            : inout std_logic_vector(15 downto 0);
        DRAM_DQM           : out   std_logic_vector(1 downto 0);
        DRAM_RAS_N         : out   std_logic;
        DRAM_WE_N          : out   std_logic;

        -- GPIO_0, GPIO_0 connected to D5M - 5M Pixel Camera
        GPIO_0_D5M_D       : in    std_logic_vector(11 downto 0);
        GPIO_0_D5M_FVAL    : in    std_logic;
        GPIO_0_D5M_LVAL    : in    std_logic;
        GPIO_0_D5M_PIXCLK  : in    std_logic;
        GPIO_0_D5M_RESET_N : out   std_logic;
        GPIO_0_D5M_SCLK    : inout std_logic;
        GPIO_0_D5M_SDATA   : inout std_logic;
        GPIO_0_D5M_STROBE  : in    std_logic;
        GPIO_0_D5M_TRIGGER : out   std_logic;
        GPIO_0_D5M_XCLKIN  : out   std_logic
    );
end entity DE0_Nano_top_level;

architecture rtl of DE0_Nano_top_level is
    component system is
        port(
            clk_clk                          : in    std_logic                     := 'X';
            sdram_clk_clk                    : out   std_logic;
            reset_reset_n                    : in    std_logic                     := 'X';
            sdram_controller_0_addr          : out   std_logic_vector(12 downto 0);
            sdram_controller_0_ba            : out   std_logic_vector(1 downto 0);
            sdram_controller_0_cas_n         : out   std_logic;
            sdram_controller_0_cke           : out   std_logic;
            sdram_controller_0_cs_n          : out   std_logic;
            sdram_controller_0_dq            : inout std_logic_vector(15 downto 0) := (others => 'X');
            sdram_controller_0_dqm           : out   std_logic_vector(1 downto 0);
            sdram_controller_0_ras_n         : out   std_logic;
            sdram_controller_0_we_n          : out   std_logic;
            trdb_d5m_xclkin_clk              : out   std_logic;
            trdb_d5m_pixclk_clk              : in    std_logic                     := 'X';
            trdb_d5m_i2c_scl                 : inout std_logic                     := 'X';
            trdb_d5m_i2c_sda                 : inout std_logic                     := 'X';
            trdb_d5m_cmos_sensor_frame_valid : in    std_logic                     := 'X';
            trdb_d5m_cmos_sensor_line_valid  : in    std_logic                     := 'X';
            trdb_d5m_cmos_sensor_data        : in    std_logic_vector(11 downto 0) := (others => 'X')
        );
    end component system;

begin
    GPIO_0_D5M_RESET_N <= '1';
    GPIO_0_D5M_TRIGGER <= '0';

    system_inst : component system
        port map(
            clk_clk                          => CLOCK_50,
            sdram_clk_clk                    => DRAM_CLK,
            reset_reset_n                    => '1',
            sdram_controller_0_addr          => DRAM_ADDR,
            sdram_controller_0_ba            => DRAM_BA,
            sdram_controller_0_cas_n         => DRAM_CAS_N,
            sdram_controller_0_cke           => DRAM_CKE,
            sdram_controller_0_cs_n          => DRAM_CS_N,
            sdram_controller_0_dq            => DRAM_DQ,
            sdram_controller_0_dqm           => DRAM_DQM,
            sdram_controller_0_ras_n         => DRAM_RAS_N,
            sdram_controller_0_we_n          => DRAM_WE_N,
            trdb_d5m_xclkin_clk              => GPIO_0_D5M_XCLKIN,
            trdb_d5m_pixclk_clk              => GPIO_0_D5M_PIXCLK,
            trdb_d5m_i2c_scl                 => GPIO_0_D5M_SCLK,
            trdb_d5m_i2c_sda                 => GPIO_0_D5M_SDATA,
            trdb_d5m_cmos_sensor_frame_valid => GPIO_0_D5M_FVAL,
            trdb_d5m_cmos_sensor_line_valid  => GPIO_0_D5M_LVAL,
            trdb_d5m_cmos_sensor_data        => GPIO_0_D5M_D
        );

end;

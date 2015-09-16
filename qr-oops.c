#include <stdio.h>
#include <string.h>

#define QR_OOPS_CMD_NOTHING 0
#define QR_OOPS_CMD_PRINT_MESSAGES 1
#define QR_OOPS_CMD_PRINT_PACKETS 2
#define QR_OOPS_CMD_DELETE_MESSAGE 3
#define QR_OOPS_CMD_DELETE_PACKET 4
#define QR_OOPS_CMD_PAUSE 5
#define QR_OOPS_CMD_RESUME 6
#define QR_OOPS_CMD_CLEAR_QUEUE 7
#define QR_OOPS_CMD_STOP 8

#define QR_OOPS_CMD "/sys/module/kernel/parameters/qr_oops_cmd"
#define QR_OOPS_PARAM0 "/sys/module/kernel/parameters/qr_oops_param0"
#define QR_OOPS_PARAM1 "/sys/module/kernel/parameters/qr_oops_param1"

void give_cmd(int cmd, int param0, int param1)
{
	FILE *fin = fopen(QR_OOPS_PARAM0, "w");
	if (!fin)
		return;
	fprintf(fin, "%d", param0);
	fclose(fin);

	fin = fopen(QR_OOPS_PARAM1, "w");
	if (!fin)
		return;
	fprintf(fin, "%d", param1);
	fclose(fin);

	fin = fopen(QR_OOPS_CMD, "w");
	if (!fin)
		return;
	fprintf(fin, "%d", cmd);
	fclose(fin);
}

void qr_pause()
{
	give_cmd(QR_OOPS_CMD_PAUSE, 0, 0);
}

void qr_resume()
{
	give_cmd(QR_OOPS_CMD_RESUME, 0, 0);
}

void invalid_command()
{
	printf("Invalid command, please run --help\n");
}

void display_help()
{
	printf("qr-oops: \n");
	printf("\t--pause to pause QR rendering\n");
	printf("\t--resume to resume QR rendering\n");
}

int main (int argc, char *argv[])
{
	if (argc == 1)
	{
		display_help();
	}
	else if(argc == 2)
	{
		if(strcmp(argv[1], "--pause") == 0)
			qr_pause();
		else if(strcmp(argv[1], "--resume") == 0)
			qr_resume();
		else
			invalid_command();
	}
	else
	{
		invalid_command();
	}

	return 0;
}

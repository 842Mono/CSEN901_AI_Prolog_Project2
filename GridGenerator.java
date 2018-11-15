
import java.util.Random;
import java.io.*;

public class GridGenerator
{
    public static void main(String [] args)
    {
//        if(args.length == 0)
//            System.out.println("Please input grid size.");
//        if(!args[0].matches("-?\\d+"))
//            System.out.println("Please input an integer.");
//        int n = Integer.parseInt(args[0]);
//        if(n < 3)
//            System.out.println("Grid size must be at least 3x3.");
        
        GeneratePrologFile(GenerateGridString(3), 3);
    }
    
    static String GenerateGridString(int n)
    {
        Random random = new Random();
        int whiteWalkersCount = random.nextInt(n) + 2; // including obstacles
        
        int emptyCount = n*n - 1 - whiteWalkersCount - 1; // bottom right is always empty
        
        int obstaclesCount = random.nextInt(1 + whiteWalkersCount/3) + 1;
        whiteWalkersCount -= obstaclesCount; // take out the obstacles
        
        int dragonStoneLocation = random.nextInt(n*n - 1);
        int dragonStoneX = dragonStoneLocation % n;
        int dragonStoneY = dragonStoneLocation / n;
        
        String stringEncodedGrid = "";
        for(int i = 0; i < n*n - 1; ++i)
        {
            int x = i / n;
            int y = i % n;
            
            if(x == dragonStoneX && y == dragonStoneY)
            {
                stringEncodedGrid = stringEncodedGrid.concat("D");
                System.out.print("[D]");
            }
            else
            {
                String type = emptyCount == 0 ? "" : "E";
                type = whiteWalkersCount == 0 ? type : type + "W";
                type = obstaclesCount == 0 ? type : type + "X";
                
                char typeChar = type.charAt(random.nextInt(type.length()));
                
                stringEncodedGrid = stringEncodedGrid.concat(Character.toString(typeChar));
                System.out.print("[" + Character.toString(typeChar) + "]");
                
                switch(typeChar)
                {
                    case 'E': --emptyCount; break;
                    case 'W': --whiteWalkersCount; break;
                    case 'X': --obstaclesCount;
                }
            }
            if(y == n - 1)
                System.out.println();
        }
        stringEncodedGrid = stringEncodedGrid.concat("E");
        System.out.println("[E]");
        
        return stringEncodedGrid;
    }

    static void GeneratePrologFile(String gridString, int n)
    {
        Random random = new Random();
        int inventory = random.nextInt(n*n/2) + 4;
        String prolog = "maxX(" + (n-1) + ").\nmaxY(" + (n-1) + ").\ninventory(" + inventory + ").\n\n%Obstacles\n";
        for(int i = 0; i < gridString.length() - 1; ++i)
        {
            if(gridString.charAt(i) == 'X')
                prolog = prolog.concat("posObst(" + i % n + ", "+ i / n + ").\n");
        }
        
        int findDSx = 0, findDSy = 0;
        String helperCode = "\n\nallWWkilled(S) :-\n";
        prolog = prolog.concat("\n%WhiteWalkers\n");
        for(int i = 0; i < gridString.length() - 1; ++i)
        {
            if(gridString.charAt(i) == 'W') {
                prolog = prolog.concat("posWW(" + i % n + ", "+ i / n + ", s0).\n");
                helperCode = helperCode.concat("    killedWW(" + i % n + ", " + i / n + ", S),\n");
            }
            if(gridString.charAt(i) == 'D')
            {
                findDSx = i % n;
                findDSy = i / n;
            }
        }
        helperCode = helperCode.substring(0, helperCode.length() - 2) + ".\n";
        prolog = prolog.concat("\nposDS(" + findDSx + ", " + findDSy + ").\n");
        prolog = prolog.concat("\nposJon("+ n-1 + ", " + n-1 + ", 0, s0).\n");
        
        System.out.println("\n\n%Generated Prolog Code:\n" + prolog + helperCode);
        
        try (Writer writer = new BufferedWriter(new OutputStreamWriter(
        new FileOutputStream("grid.pl"), "utf-8")))
        {
            writer.write(prolog + helperCode);

        }
        catch(Exception e){ System.out.print(e); }
    }
}

import java.util.Random;
import java.io.*;

public class GridGenerator
{
    public static void main(String [] args)
    {
        if(args.length == 0)
            System.out.println("Please input grid size.");
        if(!args[0].matches("-?\\d+"))
            System.out.println("Please input an integer.");
        int n = Integer.parseInt(args[0]);
        if(n < 3)
            System.out.println("Grid size must be at least 3x3.");
        
        GeneratePrologFile(GenerateGridString(n), n);
    }
    
    static String GenerateGridString(int n)
    {
        Random random = new Random();
        int whiteWalkersCount = random.nextInt(n*(n-1)) + 1; // including obstacles for now
        
        int emptyCount = n*n - 1 - whiteWalkersCount - 1; // bottom right is always empty
        
        int obstaclesCount = whiteWalkersCount - random.nextInt(1 + whiteWalkersCount/2) - 1;
        whiteWalkersCount -= obstaclesCount; // take out the obstacles
        
        int dragonStoneLocation = random.nextInt(n*n - 1);
        int dragonStoneX = dragonStoneLocation % n;
        int dragonStoneY = dragonStoneLocation / n;
        
        //System.out.println("debug: " + whiteWalkersCount + " " + emptyCount + " " + obstaclesCount);
        
        String stringEncodedGrid = "";
        for(int i = 0; i < n*n - 1; ++i)
        {
            int x = i / n;
            int y = i % n;
            //System.out.println(x + " " +y);
            if(x == dragonStoneX && y == dragonStoneY)
            {
                stringEncodedGrid = stringEncodedGrid.concat("D");
                System.out.print("[D]");
            }
            else
            {
                //int remainingCellTypes = emptyCount == 0 ? 0 : 1;
                //remainingCellTypes = whiteWalkersCount == 0 ? remainingCellTypes : remainingCellTypes + 1;
                //remainingCellTypes = obstaclesCount == 0 ? remainingCellTypes : remainingCellTypes + 1;
                
                //int type = remainingCellTypes == 1 ? 0 : random.nextInt(remainingCellTypes);
                
                String type = emptyCount == 0 ? "" : "E";
                type = whiteWalkersCount == 0 ? type : type + "W";
                type = obstaclesCount == 0 ? type : type + "X";
                //System.out.println("Debug: " + type);
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
        String prolog = "maxX(" + n + ").\nmaxY(" + n + ").\n\n%Obstacles\n";
        for(int i = 0; i < gridString.length() - 1; ++i)
        {
            if(gridString.charAt(i) == 'X')
                prolog = prolog.concat("posObst(" + i / n + ", "+ i % n + ").\n");
        }
        
        int findDSx = 0, findDSy = 0;
        prolog = prolog.concat("\n%WhiteWalkers\n");
        for(int i = 0; i < gridString.length() - 1; ++i)
        {
            if(gridString.charAt(i) == 'W')
                prolog = prolog.concat("posWW(" + i / n + ", "+ i % n + ").\n");
            if(gridString.charAt(i) == 'D')
            {
                findDSx = i % n;
                findDSy = i / n;
            }
        }
        prolog = prolog.concat("\nposDS(" + findDSx + ", " + findDSy + ").\n");
        
        System.out.println("\n\n%Generated Prolog Code:\n" + prolog);
        
        try (Writer writer = new BufferedWriter(new OutputStreamWriter(
        new FileOutputStream("grid.pl"), "utf-8")))
        {
            writer.write(prolog);
        }
        catch(Exception e){ System.out.print(e); }
    }
}
